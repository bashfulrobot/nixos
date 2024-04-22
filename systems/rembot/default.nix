{ config, pkgs, lib, inputs, secrets, ... }:

{
  imports = [ # Include the results of the hardware scan.

    ./video # video specific configuration
    ./hardware # hardware specific configuration
    ../../modules # common modules to all workstations
    ../../modules/rembot.nix # workstation specific modules

  ];

  networking.hostName = "rembot"; # Define your hostname.
}
