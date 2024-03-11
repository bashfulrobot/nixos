{ config, pkgs, lib, inputs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./boot.nix
    ./hardware-configuration.nix
    ./hardware-quirks.nix
    ./virtualization.nix
    ../modules
    ../modules/syncthing/evo.nix
    ../modules/syncthing/common.nix
    ../modules/hosts
    ../modules/desktops/gnome
    # ../modules/kolide
  ];

  networking.hostName = "evo"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

}
