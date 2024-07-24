# https://github.com/budimanjojo/dotfiles
{ user-settings, pkgs, config, lib, inputs, ... }:
let

  cfg = config.desktops.hyprland;

in {

  options = {
    desktops.hyprland.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Hyprland Desktop";
    };
  };
  config = lib.mkIf cfg.enable {

    programs = {
      hyprland = {
        enable = true;
        xwayland.enable = true;
      };
    };

    desktops.hyprland = {

      config = {
        apps.enable = true;
        autostart.enable = true;
        base.enable = true;
        keymaps.enable = true;
        system.enable = true;
        theme.enable = true;
        vars.enable = true;
        wayland.enable = true;
        window-rules.enable = true;
      };

      add-ons = {
        hyprlock.enable = true;
        waybar.enable = false;
        waybar-dev.enable = true;
        rofi.enable = true;
        sddm.enable = true;
        hyprexpo.enable = false;
        hyprspace.enable = true;
      };

    };

    services = { hypridle.enable = true; };

    ##### Home Manager Config options #####
    home-manager.users."${user-settings.user.username}" = {

      services = {
        # Notifications
        mako = {
          enable = true;
          icons = true;
          font = "Work Sans 12";
          borderRadius = 6;
          borderSize = 2;
          # margin = "10";
          padding = "25";
          # "top-right", "top-center", "top-left", "bottom-right", "bottom-center", "bottom-left", "center"
          anchor = "top-center";
        };
      };

    };
  };
}
