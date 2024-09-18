{ user-settings, lib, config, ... }:
let cfg = config.nixcfg.home-manager;

in {

  options = {
    nixcfg.home-manager.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the home-manager cfg.";
    };
  };

  config = lib.mkIf cfg.enable {

    home-manager.users."${user-settings.user.username}" = {
      # Home Manager needs a bit of information about you and the
      # paths it should manage.
      home = {
        username = "${user-settings.user.username}";
        homeDirectory = "${user-settings.user.home}";

        # This value determines the Home Manager release that your
        # configuration is compatible with. This helps avoid breakage
        # when a new Home Manager release introduces backwards
        # incompatible changes.
        #
        # You can update Home Manager without changing this value. See
        # the Home Manager release notes for a list of state version
        # changes in each release.
        # stateVersion = "23.11";
        stateVersion = "24.05";
      };
      programs.home-manager.enable = true;
    };
  };
}