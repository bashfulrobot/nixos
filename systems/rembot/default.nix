{ config, pkgs, lib, inputs, secrets, ... }:

{
  imports = [ # Include the results of the hardware scan.

    ./hardware # hardware specific configuration
    ./video # video specific configuration
    ../../modules/autoimport.nix # autoimport modules
  ];
  # User name specified in the settings
  users.default.enable = true;

  archetype = {
    tower.enable = true;
    workstation.enable = true;
  };

  suites = { tech-support.enable = true; };

  desktops.gnome.enable = true;
  # desktops = {
  #   hyprland.enable = true;
  #   addons.waybar.enable = true;
  #   addons.hyprswitch.enable = true;
  # };

  apps = {
    syncthing = {
      enable = true;
      host.rembot = true;
    };

    desktopFile = {
      enable = true;
      reboot-firmware = true;
      reboot-windows = true;
      seabird = true;
      beeper = true;
      monokle = true;
      cursor = true;
      spacedrive = true;
      solaar = true;
      warp = true;

    };
  };

  networking.hostName = "rembot"; # Define your hostname.

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
