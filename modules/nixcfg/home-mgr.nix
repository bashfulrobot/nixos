{ lib, config, ... }:
let
  cfg = config.nixcfg.home-manager;
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {

  options = {
    nixcfg.home-manager.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the home-manager cfg.";
    };
  };

  config = lib.mkIf cfg.enable {

    home-manager.users."${username}" = {
      # Home Manager needs a bit of information about you and the
      # paths it should manage.
      home.username = "${username}";
      home.homeDirectory = "/home/${username}";

      # imports = [

      # ];

      # This value determines the Home Manager release that your
      # configuration is compatible with. This helps avoid breakage
      # when a new Home Manager release introduces backwards
      # incompatible changes.
      #
      # You can update Home Manager without changing this value. See
      # the Home Manager release notes for a list of state version
      # changes in each release.
      home.stateVersion = "23.11";
      programs.home-manager.enable = true;
    };
  };
}
