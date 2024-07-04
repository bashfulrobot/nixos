{ user-settings, pkgs, config, lib, inputs, ... }:
let
  cfg = config.desktops.addons.wayland;
  # Used in my home manager code at the bottom of the file.

in {
  options = {
    desktops.addons.wayland.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable wayland settings/apps";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      xorg.xwininfo # Get StartupWMClass from a window in xwayland
      wtype # xdotool type for wayland
      wlrctl # Command line utility for miscellaneous wlroots Wayland extensions
      # wshowkeys # Show keys pressed in wayland
      wl-clipboard # Wayland clipboard - needed for espanso
      wl-color-picker # Wayland color picker
      xwaylandvideobridge # Utility to allow streaming Wayland windows to X applications
    ];

    home-manager.users."${user-settings.user.username}" = {
      home.sessionVariables = {
        XDG_SESSION_TYPE = "wayland";
        QT_QPA_PLATFORM = "wayland";
        ELECTRON_OZONE_PLATFORM_HINT = "wayland";
        GDK_BACKEND = "wayland,x11";
        MOZ_ENABLE_WAYLAND = "1";
        _JAVA_AWT_WM_NONREPARENTING = "1";
        XDG_SCREENSHOTS_DIR = "$HOME/Pictures/Screenshots";
      };
      home.file.".config/electron-flags.conf".text = ''
        --enable-features=UseOzonePlatform
        --ozone-platform=wayland
        --enable-features=WaylandWindowDecorations
        --force-device-scale-factor=1
      '';
    };
  };
}
