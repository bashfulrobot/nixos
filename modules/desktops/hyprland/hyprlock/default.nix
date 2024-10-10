# https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/
{ user-settings, pkgs, config, lib, ... }:
let
  cfg = config.desktops.hyprland.hyprlock;

  foreground = "rgba(216, 222, 233, 0.70)";
  imageStr = toString config.stylix.image;
  font = config.stylix.fonts.serif.name;

in {
  options = {
    desktops.hyprland.hyprlock.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable hyprlock.";
    };
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = with pkgs;
      [

      ];

    home-manager.users."${user-settings.user.username}" = {

      programs.hyprlock = {
        enable = true;
        settings = {
          general = {
            disable_loading_bar = false;
            grace = 0;
            hide_cursor = true;
            no_fade_in = false;
          };
          # BACKGROUND
          background = {
            monitor = "";
            path = imageStr;
            blur_passes = 3;
            blur_size = 8;
            contrast = 0.8916;
            brightness = 0.7172;
            vibrancy = 0.1696;
            vibrancy_darkness = 0.0;
          };

          label = [
            {
              # Day-Month-Date
              monitor = "";
              text = ''cmd[update:1000] echo -e "$(date +"%A, %B %d")"'';
              color = foreground;
              font_size = 28;
              font_family = font + " Bold";
              position = "0, 490";
              halign = "center";
              valign = "center";
            }
            # Time
            {
              monitor = "";
              text = ''cmd[update:1000] echo "<span>$(date +"%I:%M")</span>"'';
              color = foreground;
              font_size = 160;
              font_family = "steelfish outline regular";
              position = "0, 370";
              halign = "center";
              valign = "center";
            }
            # USER
            {
              monitor = "";
              text = "    $USER";
              color = foreground;
              outline_thickness = 2;
              dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
              dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
              dots_center = true;
              font_size = 18;
              font_family = font + " Bold";
              position = "0, -180";
              halign = "center";
              valign = "center";
            }
          ];

          #     # INPUT FIELD
          input-field = [{
            monitor = "";
            size = "300, 60";
            outline_thickness = 2;
            dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
            dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
            dots_center = true;
            outer_color = "rgba(255, 255, 255, 0)";
            inner_color = "rgba(255, 255, 255, 0.1)";
            font_color = foreground;
            fade_on_empty = false;
            font_family = font + " Bold";
            placeholder_text = "<i>🔒 Enter Password</i>";
            hide_input = false;
            position = "0, -250";
            halign = "center";
            valign = "center";
          }];
        };
      };
    };
  };
}
