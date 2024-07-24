# https://github.com/budimanjojo/dotfiles
{ user-settings, pkgs, config, lib, inputs, ... }:
let

  cfg = config.desktops.hyprland.config.vars;

in {

  options = {
    desktops.hyprland.config.vars.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Hyprland Variables";
    };
  };
  config = lib.mkIf cfg.enable {

    ##### Home Manager Config options #####
    home-manager.users."${user-settings.user.username}" = {

      wayland.windowManager = {
        hyprland = {
          settings = {

            #  variables
            "$mod" = "SUPER";
            "$alt" = "ALT";
            # Vim navigation
            "$left" = "h";
            "$down" = "j";
            "$up" = "k";
            "$right" = "l";

            # Default applications
            "$terminal" = "foot";
            "$browser" = "brave";
            "$gui-editor" = "code";
            "$cli-editor" = "nvim";
            "$filemanager" = "pcmanfm";

            # Screenshots
            "$screenshotarea" =
              "hyprctl keyword animation 'fadeOut,0,0,default' &&  grimblast save area - | swappy -f - && hyprctl keyword animation 'fadeOut,1,4,default'";

            # Mode string to show on bar
            "$resize" =
              "Resize: (h/Left) width-, (j/Down) height-, (k/Up) height+, (l/Right) width+";
            "$system" =
              "System: (l) lock, (e) logout, (r) reboot, (s) shutdown (f) uefi";
            "$screenshot" =
              "Screenshot: (Enter) Full Screenshot, (S) Select Region";
            # locker command
            "$locker" = "swaylock && sleep 1";
            # grim command
            "$grim_capture" =
              "IMG=~/Desktop/$(date +%Y%m%d_%Hh%mm%Ss)_grim.png && grim $IMG && wl-copy < $IMG";
            "$grim_region" = ''
              IMG=~/Desktop/$(date +%Y%m%d_%Hh%mm%Ss)_grim.png && grim -g "$(slurp)" $IMG && wl-copy < $IMG'';
            # Monitors
            # "$monleft" = "${mon1}";
            # "$monright" = "${mon2}";
            # Tokyonight Night colors
            "$border-color" = "rgb(A9B1D6)";
            "$bg-color" = "rgb(1A1B26)";
            "$inac-bg-color" = "rgb(1A1B26)";
            "$text-color" = "rgb(F7768E)";
            "$inac-text-color" = "rgb(A9B1D6)";
            "$urgent-bg-color" = "rgb(F7768E)";
            "$indi-color" = "rgb(7AA2F7)";
            "$urgent-text-color" = "rgb(A9B1D6)";

          };

        };

      };
    };
  };
}
