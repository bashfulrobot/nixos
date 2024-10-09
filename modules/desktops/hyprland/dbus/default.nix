# https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/
{ user-settings, pkgs, config, lib, ... }:
let cfg = config.desktops.hyprland.dbus;

in {
  options = {
    desktops.hyprland.dbus.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable dbus.";
    };
  };

  config = lib.mkIf cfg.enable {

    services.dbus = {
      enable = true;
      packages = [ pkgs.dconf ];
    };

    programs.dconf = { enable = true; };

    environment.systemPackages = with pkgs;
      [

      ];

    home-manager.users."${user-settings.user.username}" = {

    };
  };
}
