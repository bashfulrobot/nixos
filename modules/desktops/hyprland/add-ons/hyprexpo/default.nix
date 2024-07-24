{ user-settings, pkgs, config, lib, inputs, system, ... }:
with lib;
let cfg = config.desktops.hyprland.add-ons.hyprexpo;
in {
  options.desktops.hyprland.add-ons.hyprexpo.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable hyprexpo for hyprland";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [
        #waybar-clock-hover
      ];

    home-manager.users.${user-settings.user.username} = {
      wayland.windowManager.hyprland = {

        plugins = [ pkgs.hyprlandPlugins.hyprexpo ];

        settings = {
          #  variables
            "$mod" = "SUPER";
            "$alt" = "ALT";

          "plugin:hyprexpo" = {

            columns = 4;
            gap_size = 10;
            bg_col = "rgb(111111)";
            # workspace_method = "first 1";
            workspace_method = "center current";

            enable_gesture = true; # laptop touchpad
            gesture_fingers = 3; # 3 or 4
            gesture_distance = 300; # how far is the "max"
            gesture_positive =
              true; # positive = swipe down. Negative = swipe up.

          };

          bind = [ "$mod SHIFT, O, hyprexpo:expo, toggle" ];

        };

      };
    };
  };
}
