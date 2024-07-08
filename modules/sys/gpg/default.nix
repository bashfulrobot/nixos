{ user-settings, pkgs, config, lib, ... }:

let
  cfg = config.sys.gpg;

in {

  options = {
    sys.gpg.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable gpg.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = false; # using gnome-keyring
      pinentryPackage = pkgs.pinentry-gnome3;
    };

    home-manager.users."${user-settings.user.username}" = {
      ### GPG
      programs.gpg = { enable = true; };

      services.gpg-agent = {
        enable = true;
        enableBashIntegration = true;
        enableFishIntegration = true;
        # May not be needed. Testing
        enableSshSupport = false; # using gnome-keyring

      };

      ### Gnome-Keyring
      services.gnome-keyring = {
        enable = true;
        components = [ "pkcs11" "secrets" "ssh" ];
      };
    };
  };
}
