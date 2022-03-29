#include "include/betrayal/betrayal_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>

#include <shellapi.h>
#include <strsafe.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <map>
#include <memory>
#include <sstream>

#include "icon_manager.hpp"

namespace Betrayal
{

  std::unique_ptr<flutter::MethodChannel<flutter::EncodableValue>,
                  std::default_delete<flutter::MethodChannel<flutter::EncodableValue>>>
      channel = nullptr;

  class BetrayalPlugin : public flutter::Plugin
  {
  public:
    static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

    BetrayalPlugin(flutter::PluginRegistrarWindows *registrar);

    virtual ~BetrayalPlugin();

  private:
    flutter::PluginRegistrarWindows *registrar;

    // The ID of the WindowProc delegate registration.
    int window_proc_id = -1;
    IconManager icons;

    // Called when a method is called on this plugin's channel from Dart.
    std::optional<LRESULT> BetrayalPlugin::HandleWindowProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
    {
      std::optional<LRESULT> result;

      // https://wiki.winehq.org/List_Of_Windows_Messages
      if (message == WM_DESTROY)
      {
        icons.clear_all();
      }
      else if (message >= WM_USER && message < WM_APP)
      {
        switch (lParam)
        {
        case WM_LBUTTONUP:
          Print("Left Click!");
          break;
        case WM_RBUTTONUP:
          Print("Right Click!");
          break;
        default:
          LogWindowProc(hWnd, message, wParam, lParam);
          break;
        }
      }

      return result;
    };

    HWND BetrayalPlugin::GetMainWindow()
    {
      return ::GetAncestor(registrar->GetView()->GetNativeWindow(), GA_ROOT);
    };

    void LogWindowProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
    {
      flutter::EncodableMap data;
      data[flutter::EncodableValue("message")] = flutter::EncodableValue(static_cast<int>(message));
      data[flutter::EncodableValue("hWnd")] = flutter::EncodableValue(PtrToInt(hWnd));
      data[flutter::EncodableValue("wParam")] = flutter::EncodableValue(static_cast<int>(wParam));
      data[flutter::EncodableValue("lParam")] = flutter::EncodableValue(static_cast<int>(lParam));
      channel->InvokeMethod("logWindowProc", std::make_unique<flutter::EncodableValue>(data));
    }

    void Print(const std::string &message)
    {
      channel->InvokeMethod("print", std::make_unique<flutter::EncodableValue>(message));
    }

#define WITH_ARGS const flutter::EncodableMap &args = std::get<flutter::EncodableMap>(*method_call.arguments())
#define WITH_HWND HWND hWnd = GetMainWindow();
#define WITH_ID const int id = std::get<int>(args.at(flutter::EncodableValue("id")));

    void HandleMethodCall(
        const flutter::MethodCall<flutter::EncodableValue> &method_call,
        std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result)
    {
      if (method_call.method_name().compare("addTray") == 0)
      {
        WITH_ARGS;
        WITH_HWND;
        WITH_ID;
        AddTray(hWnd, id, std::move(result));
      }
      else if (method_call.method_name().compare("disposeTray") == 0)
      {
        WITH_ARGS;
        WITH_HWND;
        WITH_ID;
        DisposeTray(hWnd, id, std::move(result));
      }
      else if (method_call.method_name().compare("hideIcon") == 0)
      {
        WITH_ARGS;
        WITH_HWND;
        WITH_ID;
        HideIcon(hWnd, id, std::move(result));
      }
      else if (method_call.method_name().compare("showIcon") == 0)
      {
        WITH_ARGS;
        WITH_HWND;
        WITH_ID;
        ShowIcon(hWnd, id, std::move(result));
      }
      else if (method_call.method_name().compare("setTooltip") == 0)
      {
        WITH_ARGS;
        WITH_HWND;
        WITH_ID;
        auto tooltip = std::get<std::string>(args.at(flutter::EncodableValue("tooltip")));
        SetTooltip(hWnd, id, tooltip, std::move(result));
      }
      else if (method_call.method_name().compare("setIconFromPath") == 0)
      {
        WITH_ARGS;
        WITH_HWND;
        WITH_ID;
        auto path = std::get<std::string>(args.at(flutter::EncodableValue("path")));
        auto is_shared = std::get<bool>(args.at(flutter::EncodableValue("isShared")));
        SetIconFromPath(hWnd, id, path, is_shared, std::move(result));
      }
      else if (method_call.method_name().compare("setIconAsWinIcon") == 0)
      {
        WITH_ARGS;
        WITH_HWND;
        WITH_ID;
        auto resource_id = std::get<int>(args.at(flutter::EncodableValue("resourceId")));
        SetIconAsWinIcon(hWnd, id, resource_id, std::move(result));
      }
      else if (method_call.method_name().compare("setIconFromPixels") == 0)
      {
        WITH_ARGS;
        WITH_HWND;
        WITH_ID;
        auto width = std::get<int>(args.at(flutter::EncodableValue("width")));
        auto height = std::get<int>(args.at(flutter::EncodableValue("height")));
        auto pixels = std::get<std::vector<int32_t>>(args.at(flutter::EncodableValue("pixels")));

        SetIconFromPixels(hWnd, id, width, height, (uint32_t *)pixels.data(), std::move(result));
      }
      else
      {
        result->NotImplemented();
      }
    };

#undef WITH_ARGS
#undef WITH_HWND
#undef WITH_ID

    void AddTray(
        const HWND hWnd, const UINT id,
        std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>>
            result)
    {
      auto icon = new TrayIcon(hWnd, id);
      icons.manage(icon);

      result->Success(flutter::EncodableValue(static_cast<int>(id)));
    };

    void DisposeTray(
        const HWND hWnd, const UINT id,
        std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>>
            result)
    {
      icons.dispose(hWnd, id);

      result->Success(flutter::EncodableValue(true));
    };

    void HideIcon(
        const HWND hWnd, const UINT id,
        std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>>
            result)
    {
      if (icons.get(hWnd, id)->hide())
      {
        result->Success(flutter::EncodableValue(true));
      }
      else
      {
        result->Error("Failed to hide icon");
      }
    };

    void ShowIcon(
        const HWND hWnd, const UINT id,
        std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>>
            result)
    {
      if (icons.get(hWnd, id)->show())
      {
        result->Success(flutter::EncodableValue(true));
      }
      else
      {
        result->Error("Failed to show icon");
      }
    };

    void SetTooltip(
        const HWND hWnd, const UINT id, const std::string &tooltip,
        std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>>
            result)
    {
      auto icon = icons.get(hWnd, id);
      if (icon == nullptr)
      {
        result->Error("Icon not found");
        return;
      }

      icon->set_tooltip(tooltip);
      result->Success(flutter::EncodableValue(true));
    };

    void SetIconFromPath(
        const HWND hWnd, const UINT id, const std::string &filepath, const bool is_shared,
        std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>>
            result)
    {
      auto icon = icons.get(hWnd, id);
      if (icon == nullptr)
      {
        result->Error("Icon not found");
        return;
      }

      auto path = std::wstring(filepath.begin(), filepath.end());

      HICON hIcon = static_cast<HICON>(
          LoadImage(
              nullptr, path.c_str(), IMAGE_ICON,
              GetSystemMetrics(SM_CXSMICON),
              GetSystemMetrics(SM_CYSMICON),
              LR_LOADFROMFILE + (is_shared ? LR_SHARED : 0x0)));

      icon->set_icon(hIcon, is_shared);
      result->Success(flutter::EncodableValue(true));
    };

    void SetIconAsWinIcon(
        const HWND hWnd, const UINT id, const UINT resource_id,
        std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>>
            result)
    {
      auto icon = icons.get(hWnd, id);
      if (icon == nullptr)
      {
        result->Error("Icon not found");
        return;
      }

      icon->set_icon(LoadIcon(nullptr, MAKEINTRESOURCE(resource_id)), true);
      result->Success(flutter::EncodableValue(true));
    };

#pragma warning(disable : 4244)
      // https://cs.github.com/openjdk/jdk/blob/6013d09e82693a1c07cf0bf6daffd95114b3cbfa/src/java.desktop/windows/native/libawt/windows/awt_TrayIcon.cpp#L649
    HICON CreateIconFromBytes(HWND hWnd, int width, int height, uint32_t *bytes, TrayIcon *icon)
    {

      BITMAPV5HEADER bmhHeader = {0};
      bmhHeader.bV5Size = sizeof(BITMAPV5HEADER);
      bmhHeader.bV5Width = width;
      bmhHeader.bV5Height = -height;
      bmhHeader.bV5Planes = 1;
      bmhHeader.bV5BitCount = 32;
      bmhHeader.bV5Compression = BI_BITFIELDS;
      bmhHeader.bV5RedMask = 0x00FF0000;
      bmhHeader.bV5GreenMask = 0x0000FF00;
      bmhHeader.bV5BlueMask = 0x000000FF;
      bmhHeader.bV5AlphaMask = 0xFF000000;

      char *ptrImageData = new char[width * height * 4];

      auto dc = GetDC(hWnd);

      HBITMAP hbmpBitmap = CreateDIBSection(dc, (BITMAPINFO *)&bmhHeader, DIB_RGB_COLORS, (void **)&ptrImageData, NULL, 0);

      uint32_t *srcPtr = bytes;
      char *dstPtr = ptrImageData;

      for (int y = 0; y < height; y++)
      {
        for (int x = 0; x < width; x++)
        {
          uint32_t pixel = *srcPtr++;
          uint8_t alpha = (pixel >> 24) & 0xFF;
          uint8_t blue = (pixel >> 16) & 0xFF;
          uint8_t green = (pixel >> 8) & 0xFF;
          uint8_t red = pixel & 0xFF;
          *dstPtr++ = blue;
          *dstPtr++ = green;
          *dstPtr++ = red;
          *dstPtr++ = alpha;
        }
      }
#pragma warning(default : 4244)

      HBITMAP hBitmap = CreateDIBitmap(dc, (BITMAPINFOHEADER *)&bmhHeader, CBM_INIT, ptrImageData, (BITMAPINFO *)&bmhHeader, DIB_RGB_COLORS);

      ReleaseDC(hWnd, dc); // 1: success 0: failure
      DeleteObject(hbmpBitmap);

      HBITMAP hMask = CreateBitmap(width, height, 1, 1, NULL);

      ICONINFO iconInfo;
      memset(&iconInfo, 0, sizeof(ICONINFO));
      iconInfo.hbmMask = hMask;
      iconInfo.hbmColor = hBitmap;
      iconInfo.fIcon = TRUE;
      iconInfo.xHotspot = 0;
      iconInfo.yHotspot = 0;

      HICON hIcon = CreateIconIndirect(&iconInfo);

      DeleteObject(hBitmap);
      DeleteObject(hMask);

      return hIcon;
    }

    void SetIconFromPixels(
        const HWND hWnd, const UINT id, const UINT width, const UINT height,
        uint32_t *pixels,
        std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>>
            result)
    {
      auto icon = icons.get(hWnd, id);
      if (icon == nullptr)
      {
        result->Error("Icon not found");
        return;
      }

      auto hIcon = CreateIconFromBytes(
          hWnd, width, height, pixels, icon);

      icon->set_icon(hIcon, true);
      icon->update();

      result->Success(flutter::EncodableValue(true));
    }
  };

  // static
  void BetrayalPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarWindows *registrar)
  {
    channel =
        std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
            registrar->messenger(), "betrayal",
            &flutter::StandardMethodCodec::GetInstance());

    auto plugin = std::make_unique<BetrayalPlugin>(registrar);

    channel->SetMethodCallHandler(
        [plugin_pointer = plugin.get()](const auto &call, auto result)
        {
          plugin_pointer->HandleMethodCall(call, std::move(result));
        });

    registrar->AddPlugin(std::move(plugin));
  }

  BetrayalPlugin::BetrayalPlugin(flutter::PluginRegistrarWindows *registrar) : registrar(registrar)
  {
    window_proc_id = registrar->RegisterTopLevelWindowProcDelegate(
        [this](HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
        {
          return this->HandleWindowProc(hWnd, message, wParam, lParam);
        });
  }

  BetrayalPlugin::~BetrayalPlugin()
  {
    registrar->UnregisterTopLevelWindowProcDelegate(window_proc_id);
  }

} // namespace

void BetrayalPluginRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar)
{
  Betrayal::BetrayalPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
