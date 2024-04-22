{ ... }:

{
  imports = [
    ./desktops/gnome # Desktop for this system
    ./syncthing/evo # Syncthing configuration
    ./desktop-files/laptop
    # ./kolide
  ];
}
