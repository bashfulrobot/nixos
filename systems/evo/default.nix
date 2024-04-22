{ config, pkgs, lib, inputs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./boot.nix
    ./hardware-configuration.nix # Include the hardware-configuration.nix file from installation
    ./nixos-hardware.nix # hardware specific configuration
    ../../modules/desktops/gnome # Desktop for this system
    ../../modules # common modules to all workstations
    ../../modules/syncthing

    ../../modules/desktop-files/laptop
    # ../../modules/kolide
  ];

  networking.hostName = "evo"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

}
