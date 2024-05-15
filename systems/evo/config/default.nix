{ ... }:

{
  imports = [ ../../../modules/autoimport.nix ];

  archetype = {
    laptop.enable = true;
    workstation.enable = true;
  };

  users.dustin.enable = true;

  # desktops.gnome.enable = true;
  desktops.pantheon.enable = true;

  apps = {
    syncthing = {
      enable = true;
      host.evo = true;
    };

    desktopFile = {
      enable = true;
      reboot-firmware = true;
      seabird = true;
      beeper = true;
      monokle = true;
      cursor = true;
      spacedrive = true;
    };
  };

  networking.hostName = "evo"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
