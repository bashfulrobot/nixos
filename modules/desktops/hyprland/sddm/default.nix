# https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/
{ user-settings, pkgs, config, lib, ... }:
let
  cfg = config.desktops.hyprland.sddm;

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

    environment.systemPackages = with pkgs; [

    ];

    home-manager.users."${user-settings.user.username}" = {

    };
  };
}
