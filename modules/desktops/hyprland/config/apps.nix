# https://github.com/budimanjojo/dotfiles
{ user-settings, pkgs, config, lib, inputs, ... }:
let

  cfg = config.desktops.hyprland.config.apps;

in {

  options = {
    desktops.hyprland.config.apps.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Apps needed for Hyprland";
    };
  };
  config = lib.mkIf cfg.enable {

    # https://wiki.archlinux.org/title/PCManFM
    environment = {
      systemPackages = with pkgs; [ accountsservice pcmanfm grimblast swappy bemoji ];
    };

    programs = { seahorse.enable = true; };

    cli = {
      foot.enable = true;
      yazi.enable = true;
    };

    ##### Home Manager Config options #####
    home-manager.users."${user-settings.user.username}" = {

      home.file = {
        ".config/pcmanfm/default/pcmanfm.conf".source =
          ./build/cfg/pcmanfm/pcmanfm.conf;
        ".config/swappy/config".source = ./build/cfg/swappy/config;
      };

    };
  };
}
