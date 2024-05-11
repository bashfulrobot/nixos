{ config, pkgs, lib, inputs, secrets, ... }:

{
  imports = [ # Include the results of the hardware scan.

    ./hardware # hardware specific configuration
    ./config # workstation specific modules

  ];

}
