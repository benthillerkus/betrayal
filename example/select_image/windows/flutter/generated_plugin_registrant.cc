//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <betrayal/betrayal_plugin.h>
#include <native_context_menu/native_context_menu_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  BetrayalPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("BetrayalPlugin"));
  NativeContextMenuPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("NativeContextMenuPlugin"));
}
