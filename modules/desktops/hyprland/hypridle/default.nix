# https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/
{ user-settings, pkgs, config, lib, ... }:
let cfg = config.desktops.hyprland.hypridle;

in {
  options = {
    desktops.hyprland.hypridle.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable hypridle.";
    };
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = with pkgs;
      [

      ];

    home-manager.users."${user-settings.user.username}" = {
      services.hypridle = {
        enable = true;
        settings = rec {
          general = {
            before_sleep_cmd = "loginctl lock-session";
            lock_cmd = "pidof hyprlock || hyprlock";
            after_sleep_cmd = "hyprctl dispatch dpms on";
            ignore_dbus_inhibit = false;
          };

          /* TODO have these listeners in this order:
             1. dim screen (brightnessctl)
             2. turn off screen (hyprctl dpms)
             3. suspend (systemctl, also fix the before_sleep_cmd to actually run on suspend)
          */
          listener = [
            {
              timeout = 300;
              on-timeout = "pidof hyprlock || hyprlock";
            }
            {
              timeout = 600;
              on-timeout = "hyprctl dispatch dpms off";
              on-resume = "hyprctl dispatch dpms on";
            }
            {
              timeout = 900;
              on-timeout = "systemctl suspend";
            }
          ];
        };
      };

    };
  };
}
