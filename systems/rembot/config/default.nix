{ ... }:

{
  imports = [
    ../../../modules/workstation/desktops/gnome # Desktop for this system
    ../../../modules/workstation/syncthing/rembot # Syncthing configuration
    ../../../modules/workstation/desktop-files/tower # Custom menu items
    ./video # video specific configuration
    # ./kolide
    ../../../src/autoimport.nix

  ];

  archetype = {
    tower.enable = true;
    workstation.enable = true;
  };

  networking.hostName = "rembot"; # Define your hostname.
}
