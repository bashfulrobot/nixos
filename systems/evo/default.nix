{ config, pkgs, lib, inputs, ... }:

{
  imports = [ # Include the results of the hardware scan.

    ./hardware # hardware specific configuration
    ./config # workstation specific modules
    ../../modules # common modules to all workstations

  ];

  networking.hostName = "evo"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

}
