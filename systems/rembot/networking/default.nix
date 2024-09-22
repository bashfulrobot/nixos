{ config, pkgs, lib, inputs, ... }:

# https://nixos.wiki/wiki/Networking
# Also has a good port forward/nat example there
{
  networking = {
    nftables = {
      enable = true;
      ruleset = ''
        table ip nat {
          chain PREROUTING {
            type nat hook prerouting priority dstnat; policy accept;
            iifname "enp34s0" tcp dport 80 dnat to 10.10.0.5:80
            iifname "enp34s0" tcp dport 22 dnat to 192.168.169.2:22
          }
        }
      '';
    };
    firewall = {
      enable = true;
      allowedTCPPorts = [ 80 22 ]; # Allow both port 80 and 22
    };
    nat = {
      enable = true;
      internalInterfaces =
        [ "virbr1" ]; # Use the libvirt bridge as the internal interface
      externalInterface =
        "enp34s0"; # Use the external bridge as the external interface
      forwardPorts = [
        {
          sourcePort = 80;
          proto = "tcp";
          destination = "10.10.0.5:80";
        }
        {
          sourcePort = 22;
          proto = "tcp";
          destination = "192.168.169.2:22";
        }
      ];
    };
  };

}
