# https://github.com/budimanjojo/dotfiles
{ user-settings, pkgs, config, lib, inputs, ... }:
let

  cfg = config.desktops.hyprland.config.base;

in {

  options = {
    desktops.hyprland.config.base.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Hyprland Base Config";
    };
  };
  config = lib.mkIf cfg.enable {

    ##### Home Manager Config options #####
    home-manager.users."${user-settings.user.username}" = {

      wayland.windowManager = {
        hyprland = {
          enable = true;
          systemd.variables = [ "--all" ];
          settings = {

            # General settings
            general = {
              resize_on_border = true;
              layout = "dwindle";
            };

            dwindle = {
              # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
              # pseudotile =
              #   "yes"; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
              preserve_split = "yes";
              force_split = 2;
            };

            xwayland = { force_zero_scaling = true; };

            input = {
              numlock_by_default = true;
              follow_mouse = 2;
              repeat_rate = 50;
              repeat_delay = 300;
            };
            misc = {
              mouse_move_enables_dpms = true;
              key_press_enables_dpms = true;
            };

            gestures = {
              workspace_swipe = true;
              workspace_swipe_forever = true;
              workspace_swipe_invert = false;
            };

            # master = { new_on_top = true; };

            # Hardware
            # Monitor placement
            # monitor = [
            #   "$monleft, preferred, 0x0, 1"
            #   "$monright, preferred, ${mon2width}x0, 1"
            # ];

            # Workspaces to monitors
            # workspace = [
            #   "1, monitor:$monleft, default:true"
            #   "2, monitor:$monright, default:true"
            #   "3, monitor:$monleft"
            #   "4, monitor:$monright"
            #   "5, monitor:$monleft"
            #   "6, monitor:$monright"
            #   "7, monitor:$monleft"
            #   "8, monitor:$monright"
            #   "9, monitor:$monleft"
            #   "10, monitor:$monright"
            # ];

          };

        };
      };
    };
  };
}
