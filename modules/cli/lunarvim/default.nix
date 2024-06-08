{ user-settings, pkgs, config, lib, ... }:
let
  cfg = config.cli.lunarvim;

in {

  options = {
    cli.lunarvim.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable lunarvim editor.";
    };
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = with pkgs;
      [
        lunarvim # opinionated neovim
      ];

    home-manager.users."${user-settings.user.username}" = {
      home = {

        sessionVariables = { EDITOR = "lvim"; };

        # file."config.lua" = {
        #   source = ./config/config.lua;
        #   target = ".config/lvim/config.lua";
        # };

      };
    };
  };
}
