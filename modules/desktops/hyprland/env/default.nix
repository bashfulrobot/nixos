# https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/
{ user-settings, pkgs, config, lib, ... }:
let cfg = config.desktops.hyprland.env;

in {
  options = {
    desktops.hyprland.env.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable env vars.";
    };
  };

  config = lib.mkIf cfg.enable {

    environment.variables = {
      NIXOS_OZONE_WL = "1";
      NIXPKGS_ALLOW_UNFREE = "1";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";
      GDK_BACKEND = "wayland,x11";
      CLUTTER_BACKEND = "wayland";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      SDL_VIDEODRIVER = "x11";
      MOZ_ENABLE_WAYLAND = "1";

      HYPRSHOT_DIR = "${user-settings.user.home}/Pictures/Screenshots";
    };

    home-manager.users."${user-settings.user.username}" = {

    };
  };
}
