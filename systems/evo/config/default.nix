{ ... }:

{
  imports = [
    ../../../modules/desktops/gnome # Desktop for this system
    ../../../modules/syncthing/evo # Syncthing configuration
    ../../../modules/desktop-files/laptop # Custom menu items
    # ../../../modules/kolide
  ];

    networking.hostName = "evo"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
}
