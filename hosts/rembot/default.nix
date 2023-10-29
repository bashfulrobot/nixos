{ config, pkgs, lib, inputs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./amdgpu.nix
    ./boot.nix
    ./firewall.nix
    ./video.nix
    ./hardware-configuration.nix
    ../modules
    ../modules/desktops/wayland
    ./steam.nix
    ../modules/syncthing/rembot.nix
    ../modules/syncthing/common.nix
    ../modules/hosts

  ];

  networking.hostName = "rembot"; # Define your hostname.
}
