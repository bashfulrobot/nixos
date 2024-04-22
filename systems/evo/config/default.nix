{ ... }:

{
  imports = [
    ../../../modules/desktops/gnome # Desktop for this system
    ../../../modules/syncthing/evo # Syncthing configuration
    ../../../modules/desktop-files/laptop # Custom menu items
    # ../../../modules/kolide
  ];
}
