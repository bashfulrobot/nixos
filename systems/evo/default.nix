{ config, pkgs, lib, inputs, ... }:

{
  imports = [ # Include the results of the hardware scan.

    ./hardware # hardware specific configuration
    ./config # workstation specific modules
    ../../modules # common modules to all workstations

  ];



}
