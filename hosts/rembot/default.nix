{ config, pkgs, lib, inputs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./amdgpu.nix
    ./boot.nix
    ./video.nix
    ./hardware-configuration.nix
    ../modules
    ./steam.nix
    ../modules/syncthing/rembot.nix
    ../modules/syncthing/common.nix

  ];

  networking.hostName = "rembot"; # Define your hostname.
}
