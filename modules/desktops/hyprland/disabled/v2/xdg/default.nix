{ pkgs, lib, config, ... }:

with lib;
let cfg = config.desktops.hyprland.xdg;

in {
    options = {
    desktops.hyprland.xdg.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable xdg on hyprland";
    };
  };
    config = mkIf cfg.enable {
        xdg.userDirs = {
            enable = true;
            documents = "$HOME/Documents/";
            download = "$HOME/Downloads/";
            videos = "$HOME/Videos/";
            music = "$HOME/Music/";
            pictures = "$HOME/Pictures/";
        };
    };
}