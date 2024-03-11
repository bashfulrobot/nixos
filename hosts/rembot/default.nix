{ config, pkgs, lib, inputs, secrets, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./amdgpu.nix
    ./boot.nix
    ./firewall.nix
    ./video.nix
    ./hardware-configuration.nix
    # ./network.nix
    ./nixos-hardware.nix
    ../modules
    ../modules/desktops/gnome
    ./steam.nix
    ../modules/syncthing/rembot.nix
    ../modules/syncthing/common.nix
    ../modules/hosts

  ];

  networking.hostName = "rembot"; # Define your hostname.
}
