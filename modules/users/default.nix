{ pkgs, config, lib, ... }:
let cfg = config.users.dustin;
in {

  options = {
    users.dustin.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the Dustin user.";
    };
  };

  config = lib.mkIf cfg.enable {

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.dustin = {
      isNormalUser = true;
      description = "Dustin Krysak";
      shell = pkgs.fish;
      extraGroups = [
        "networkmanager"
        "wheel"
        "onepassword"
        "onepassword-cli"
        "polkituser"
        "users"
        "video"
      ];
    };

    # Set your time zone.
    time.timeZone = "America/Vancouver";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_CA.UTF-8";

    # naughty
    security.sudo.wheelNeedsPassword = false;
  };

}
