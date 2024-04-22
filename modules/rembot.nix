{ ... }:

{
  imports = [
    ./desktops/gnome # Desktop for this system
    ./syncthing/rembot # Syncthing configuration
    ./desktop-files/tower
    ./steam
    # ./kolide
  ];
}
