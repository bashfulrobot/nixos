{ user-settings, pkgs, config, lib, inputs, ... }:
let
  cfg = config.desktops.addons.hyprswitch;
  # Used in my home manager code at the bottom of the file.

in {
  options = {
    desktops.addons.hyprswitch.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable hyprswitch barr";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [
        inputs.hyprswitch.packages.x86_64-linux.default # Window switcher for Hyprland installed from a flake (see flake.nix configuration file for more information)
      ];
    home-manager.users."${user-settings.user.username}" = {

    };
  };
}
