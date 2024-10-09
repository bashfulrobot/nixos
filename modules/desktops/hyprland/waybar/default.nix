# https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/
{ user-settings, pkgs, config, lib, ... }:
let cfg = config.desktops.hyprland.waybar;

in {
  options = {
    desktops.hyprland.waybar.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Waybar.";
    };
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = with pkgs;
      [

      ];

    home-manager.users."${user-settings.user.username}" = {

      imports = [
        ./config/hyprland.nix
        ./config/stats.nix
        ./config/recorder.nix
        ./config/backlight.nix
        ./config/audio.nix
        ./config/notification.nix
        ./config/network.nix
        ./config/general.nix
        ./config/power.nix

        ./config/style.nix
      ];

      stylix.targets.waybar.enable = false;
      wayland.windowManager.hyprland.settings = {
        bind = [ "SUPER,b,exec,killall -SIGUSR1 .waybar-wrapped" ];
        exec = [ "systemctl --user restart waybar" ];
      };

      programs.waybar = {
        enable = true;
        systemd.enable = true;
        settings = {
          mainBar = {
            layer = "top";
            position = "right";
            margin = "5 2 5 0";
            reload_style_on_change = true;
          };
        };
      };

    };

  };
}
