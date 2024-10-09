# https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/
{ user-settings, pkgs, config, lib, ... }:
let cfg = config.desktops.hyprland.sddm;
hostname = config.networking.hostName;

in {
  options = {
    desktops.hyprland.sddm.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable SDDM.";
    };
  };

  config = lib.mkIf cfg.enable {

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      enableHidpi = true;
      theme = "chili";
      package = pkgs.sddm;
    };

    environment.systemPackages = with pkgs;
      [
        (sddm-chili-theme.override {
          themeConfig = {
            background = config.stylix.image;
            ScreenWidth = if hostname == "rembot" then 3440 else if hostname == "evo" then 2560 else 1920;
            ScreenHeight = if hostname == "rembot" then 1440 else if hostname == "evo" then 1440 else 1080;
            blur = true;
            recursiveBlurLoops = 3;
            recursiveBlurRadius = 5;
          };
        })
      ];

    home-manager.users."${user-settings.user.username}" = {

    };
  };
}
