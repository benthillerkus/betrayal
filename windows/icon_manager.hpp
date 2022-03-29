#pragma once

#include <windows.h>

#include <string>
#include <map>

#include "tray_icon.hpp"

class IconManager
{
private:
  std::map<HWND, std::map<UINT, TrayIcon *>> all_icons;

public:
  IconManager() = default;
  ~IconManager()
  {
    clear_all();
  };

  void manage(TrayIcon *const tray_icon)
  {
    all_icons[tray_icon->data.hWnd][tray_icon->data.uID] = tray_icon;
  }

  TrayIcon *const get(HWND hWnd, UINT id)
  {
    return all_icons.at(hWnd).at(id);
  }

  void dispose(HWND hWnd, UINT id)
  {
    delete all_icons.at(hWnd).at(id);
    all_icons.at(hWnd).erase(id);
  }

  void clear_all()
  {
    for (auto window = all_icons.begin(); window != all_icons.end(); ++window)
    {
      for (auto id = window->second.begin(); id != window->second.end(); ++id)
      {
        delete id->second;
      }
    }
    all_icons.clear();
  }
};
