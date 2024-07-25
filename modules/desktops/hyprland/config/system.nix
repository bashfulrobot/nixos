# https://github.com/budimanjojo/dotfiles
{ user-settings, pkgs, config, lib, inputs, ... }:
let

  cfg = config.desktops.hyprland.config.system;
  dbus-hyprland-environment =
    pkgs.callPackage ./build/scripts/dbus-hyprland-environment.nix { };
  # Define your environment variables here
  envVars = {
    NIXOS_OZONE_WL = "1";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SCREENSHOTS_DIR = "$HOME/Pictures/Screenshots";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    MANROFFOPT = "-c";
    WARP_ENABLE_WAYLAND = 1; # Needed for Warp Terminal to use Wayland
    MOZ_ENABLE_WAYLAND = "1";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    CLUTTER_BACKEND = "wayland";
    GDK_BACKEND = "wayland";
    SDL_VIDEODRIVER = "wayland";
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

    environment = {
      systemPackages = [ dbus-hyprland-environment ];
      sessionVariables = envVars;
      variables = envVars;
    };

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

    # Whether to enable the RealtimeKit system service, which hands out realtime scheduling priority to user processes on demand. For example, the PulseAudio server uses this to acquire realtime priority.
    security.rtkit.enable = true;

    services.dbus = {
      enable = true;
      # Make the gnome keyring work properly
      # Pulled from: https://github.com/jnsgruk/nixos-config/blob/8e9bb39ab6bb32fbeb62a5cc722e2b9e07acb50c/host/common/desktop/hyprland.nix#L42
      # packages = with pkgs; [ gcr ];
    };

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      wlr.enable = true;
      # gtk portal needed to make gtk apps happy
      extraPortals =
        [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-hyprland ];
      # [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];

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
