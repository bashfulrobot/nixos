{ ... }:

{
  imports = [
    ../../../modules/desktops/gnome # Desktop for this system
    ../../../modules/syncthing/rembot # Syncthing configuration
    ../../../modules/desktop-files/tower # Custom menu items
    ../../../modules/steam # Steam configuration
    ./video # video specific configuration
    # ./kolide
  ];
}
