{ config, pkgs, lib, inputs, ... }:

# https://nixos.wiki/wiki/Networking
# Also has a good port forward/nat example there
{
  # networking = {
  #   interfaces = {
  #     enp34s0.useDHCP = true;
  #     br0.useDHCP = true;
  #   };
  #   bridges = { "br0" = { interfaces = [ "enp34s0" ]; }; };
  # };

}
