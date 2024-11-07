# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware
    ./networking
    ./config
    # ../../modules/autoimport.nix # autoimport modules
    # TODO: make an importable file of common server modules
    ../../modules/cli/nixvim
    ../../modules/cli/docker
    ../../modules/cli/fish
    ../../modules/cli/starship
    ../../modules/cli/tailscale
    ../../modules/cli/yazi
    ../../modules/apps/kvm
    ../../modules/nixcfg/home-mgr.nix
    ../../modules/nixcfg/insecure-packages.nix
    ../../modules/nixcfg/nix-settings.nix
  ];

}
