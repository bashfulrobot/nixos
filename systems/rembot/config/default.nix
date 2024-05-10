{ ... }:

{
  imports = [
    ../../../modules/workstation/desktops/gnome # Desktop for this system
    ../../../modules/workstation/syncthing/rembot # Syncthing configuration
    ../../../modules/workstation/desktop-files/tower # Custom menu items
    # ../../../modules/workstation/steam # Steam configuration
    ./video # video specific configuration
    # ./kolide
    ../../../src/autoimport.nix

  ];

  archetype = {
    core.enable = true;
    workstation.enable = true;
  };

  suites = { tech-support.enable = true; };

  networking.hostName = "rembot"; # Define your hostname.
}
