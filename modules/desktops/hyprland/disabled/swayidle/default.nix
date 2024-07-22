{ user-settings, pkgs, config, lib, inputs, ... }:
let

  cfg = config.desktops.hyprland.swayidle;

  lock =
    "exec ${pkgs.swaylock-effects}/bin/swaylock --screenshots --clock --indicator --indicator-radius 100 --indicator-thickness 7 --effect-blur 7x5 --effect-vignette 0.5:0.5 --ring-color d3869b --key-hl-color fabd2f --line-color 3c3836 --inside-color 282828 --separator-color 3c3836 --grace 2 --fade-in 0.2";
in {

  options = {
    desktops.hyprland.swayidle.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable swayidle in Hyprland Desktop";
    };
  };

  config = lib.mkIf cfg.enable {
    ##### Home Manager Config options #####
    home-manager.users."${user-settings.user.username}" = {
      services.swayidle = {
        enable = true;

        timeouts = [
          {
            timeout = 30;
            command = lock;
          }
          {
            timeout = 60;
            command = "hyprctl dispatch dpms off";
          }
        ];

        events = [
          {
            event = "before-sleep";
            command = lock;
          }
          {
            event = "after-resume";
            command = "hyprctl dispatch dpms on";
          }
        ];
      };
    };
  };

}
