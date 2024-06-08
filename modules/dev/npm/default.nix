{ user-settings, pkgs, config, lib, ... }:
let
cfg = config.dev.npm;

in {
  options = {
    dev.npm.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable NPM tooling.";
    };
  };

  config = lib.mkIf cfg.enable {
  home-manager.users."${user-settings.user.username}" = {
    home.file.".npmrc".text = ''
      prefix = ~/.npm-packages

    '';
  };
  };
}
