{ config, pkgs, lib, inputs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./boot.nix
    ./hardware-configuration.nix
    ../modules
    ../modules/syncthing/dustin-krysak.nix
    ../modules/syncthing/common.nix
    ../modules/hosts
    ../modules/desktops/gnome
  ];

  networking.hostName = "dustin-krysak"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

}
