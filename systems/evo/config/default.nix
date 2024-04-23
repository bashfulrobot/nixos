{ ... }:

{
  imports = [
    ../../../modules/workstation/desktops/gnome # Desktop for this system
    ../../../modules/workstation/syncthing/evo # Syncthing configuration
    ../../../modules/workstation/desktop-files/laptop # Custom menu items
    # ../../../modules/kolide
  ];

    networking.hostName = "evo"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
}
