{ inputs, lib, config, pkgs, ... }:
with lib;
let cfg = config.desktops.hyprland.eww;
in {
  options = {
    desktops.hyprland.eww.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable eww on hyprland";
    };
  };

  config = mkIf cfg.enable {
    ##### Home Manager Config options #####
    home-manager.users."${user-settings.user.username}" = {
      # theres no programs.eww.enable here because eww looks for files in .config
      # thats why we have all the home.files

      # eww package
      home.packages = with pkgs; [
        eww-wayland
        pamixer
        brightnessctl
        (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      ];

      # configuration
      home.file.".config/eww/eww.scss".source = ./build/cfg/eww/eww.scss;
      home.file.".config/eww/eww.yuck".source = ./build/cfg/eww/eww.yuck;

      # scripts
      home.file.".config/eww/scripts/battery.sh" = {
        source = ./build/cfg/eww/scripts/battery.sh;
        executable = true;
      };

      home.file.".config/eww/scripts/wifi.sh" = {
        source = ./build/cfg/eww/scripts/wifi.sh;
        executable = true;
      };

      home.file.".config/eww/scripts/brightness.sh" = {
        source = ./build/cfg/eww/scripts/brightness.sh;
        executable = true;
      };

      home.file.".config/eww/scripts/workspaces.sh" = {
        source = ./build/cfg/eww/scripts/workspaces.sh;
        executable = true;
      };

      home.file.".config/eww/scripts/workspaces.lua" = {
        source = ./build/cfg/eww/scripts/workspaces.lua;
        executable = true;
      };
    };
  };
}
