{ config, lib, secrets, pkgs, ... }:

let
  cfg = config.apps.one-password;
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {

  options = {
    apps.one-password.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable one-password.";
    };
  };

  config = lib.mkIf cfg.enable {

    # Enable the 1Passsword GUI with myself as an authorized user for polkit
    programs._1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "${username}" ];
    };

    home-manager.users."${username}" = {
      home.file."1password.desktop" = {
        source = ./1password.desktop;
        target = ".config/autostart/1password.desktop";
      };
    };
  };
}
