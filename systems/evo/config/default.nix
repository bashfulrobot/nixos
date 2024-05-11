{ ... }:

{
  imports = [
    ../../../modules/workstation/desktops/gnome # Desktop for this system
    ../../../modules/workstation/desktop-files/laptop # Custom menu items
    # ../../../modules/kolide
    ../../../src/autoimport.nix
  ];

  archetype = {
    laptop.enable = true;
    workstation.enable = true;
  };

  apps.syncthing = {
    enable = true;
    host.evo = true;
  };

  networking.hostName = "evo"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
}
