# https://github.com/budimanjojo/dotfiles
{ user-settings, pkgs, config, lib, inputs, ... }:
let

  cfg = config.desktops.hyprland.config.autostart;

in {

  options = {
    desktops.hyprland.config.autostart.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Autostart apps in Hyprland";
    };
  };
  config = lib.mkIf cfg.enable {

    ##### Home Manager Config options #####
    home-manager.users."${user-settings.user.username}" = {

      wayland.windowManager = {
        hyprland = {
          settings = {    # home-manager.users."${user-settings.user.username}" = {

    # };

            exec-once = [
              # "${pkgs.swaybg}/bin/swaybg -o $monleft -i ~/.config/hypr/wallpapers/tokyonight01-left.png"
              # "${pkgs.swaybg}/bin/swaybg -o $monright -i ~/.config/hypr/wallpapers/tokyonight01-right.png"
              "${pkgs.swaybg}/bin/swaybg -i ~/.config/hypr/wallpapers/wallpaper.png"
              "pcmanfm --desktop"
            ];

          };

        };

      };
    };
  };
}
