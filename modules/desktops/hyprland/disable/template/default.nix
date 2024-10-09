# https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/
{ user-settings, pkgs, config, lib, ... }:
let
  cfg = config.desktops.hyprland.waybar;

in {
  options = {
    desktops.hyprland.waybar.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Waybar.";
    };
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = with pkgs; [

    ];

    home-manager.users."${user-settings.user.username}" = {

    };
  };
}
