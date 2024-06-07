{ pkgs, config, lib, inputs, ... }:
let
  cfg = config.desktops.addons.wayland;
  # Used in my home manager code at the bottom of the file.
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {
  options = {
    desktops.addons.wayland.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable wayland settings/apps";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [
        xorg.xwininfo # Get StartupWMClass from a window in xwayland
        wtype # xdotool type for wayland
        wlrctl # Command line utility for miscellaneous wlroots Wayland extensions
        # wshowkeys # Show keys pressed in wayland
        wl-clipboard # Wayland clipboard - needed for espanso
        wl-color-picker # Wayland color picker
      ];
    home-manager.users."${username}" = {

    };
  };
}
