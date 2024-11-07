{ config, pkgs, lib, ... }:

{
  imports = [ # Include the results of the hardware scan.

    # Common modules
    ../../modules/cli/nixvim
    ../../modules/cli/fish
    ../../modules/cli/starship
    ../../modules/cli/tailscale
    ../../modules/cli/yazi
    ../../modules/nixcfg/home-mgr.nix
    ../../modules/nixcfg/insecure-packages.nix
    ../../modules/nixcfg/nix-settings.nix
  ];

}
