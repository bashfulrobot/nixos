{ ... }:

{
  imports = [
    ../../../modules/workstation/desktops/gnome # Desktop for this system
    ../../../modules/workstation/desktop-files/tower # Custom menu items
    ./video # video specific configuration
    # ./kolide
    ../../../src/autoimport.nix

  ];

  archetype = {
    tower.enable = true;
    workstation.enable = true;
  };

  apps.syncthing = {
    enable = true;
    host.rembot = true;
  };
  networking.hostName = "rembot"; # Define your hostname.
}
