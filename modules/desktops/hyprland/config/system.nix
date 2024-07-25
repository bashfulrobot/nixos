# https://github.com/budimanjojo/dotfiles
{ user-settings, pkgs, config, lib, inputs, ... }:
let

  cfg = config.desktops.hyprland.config.system;
  # Define your environment variables here
  envVars = {
    NIXOS_OZONE_WL = "1";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    CLUTTER_BACKEND = "wayland";
    GDK_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    XDG_SCREENSHOTS_DIR = "$HOME/Pictures/Screenshots";

    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    MANROFFOPT = "-c";
    WARP_ENABLE_WAYLAND = 1; # Needed for Warp Terminal to use Wayland
  };
in {

  options = {
    desktops.hyprland.config.system.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Hyprland System Config";
    };
  };
  config = lib.mkIf cfg.enable {

    environment.sessionVariables = envVars;

    fonts = {
      packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        font-awesome
        source-han-sans
        work-sans
      ];
      fontconfig.defaultFonts = {
        serif = [ "Work" "Noto Serif" "Source Han Serif" ];
        sansSerif = [ "Work Sans" "Noto Sans" "Source Han Sans" ];
      };
    };

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      wlr.enable = true;
      # gtk portal needed to make gtk apps happy
      extraPortals =
        [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
    };

    ##### Home Manager Config options #####
    home-manager.users."${user-settings.user.username}" = {
      home = {
        sessionVariables = envVars;

        file.".config/electron-flags.conf".text = ''
        --enable-features=UseOzonePlatform
        --ozone-platform=wayland
        --enable-features=WaylandWindowDecorations
        --force-device-scale-factor=1
      '';

      };
    };
  };
}
