{ pkgs, ... }: {

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

# Enable CUPS to print documents.
  services.printing.enable = true;
}
