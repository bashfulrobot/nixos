{ config, pkgs, lib, inputs, ... }: {
  boot.kernel.sysctl = {
    # Enable IP forwarding
    "net.ipv4.ip_forward" = 1;
    # controls whether packets traversing a Linux bridge will be passed through iptables' FORWARD chain. When set to 1 (enabled), it allows iptables rules to affect bridged (as opposed to just routed) traffic.
    "net.bridge.bridge-nf-call-iptables" = 1;
    "net.ipv4.conf.all.forwarding" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
    "net.ipv4.conf.all.proxy_arp" = 1;
    "net.ipv4.conf.ens2.proxy_arp" = 1;

  };

  networking = {
    nat = {
      enable = true;
      externalInterface = "enp3s0"; # Your external interface
      # Note
      # - for every routed network created in Terrraform, you need to add a new internal interface here
      # - and a static route needs to be added to the LAN router for the new network
      internalInterfaces = [
        "virbr1"
        "virbr2"
        "virbr3"
        "virbr4"
        "virbr5"
        "virbr6"
        "virbr7"
      ]; # Your KVM bridge interface
    };
    firewall = {
      enable = true;
      allowPing = true;
      allowedTCPPorts = [ ]; # Empty since we're allowing all traffic
      allowedUDPPorts = [ ]; # Empty since we're allowing all traffic
      extraCommands = lib.mkBefore ''
        # Allow all incoming and outgoing traffic on all interfaces
        iptables -A INPUT -j ACCEPT
        iptables -A OUTPUT -j ACCEPT
        iptables -A FORWARD -j ACCEPT
      '';
    };
  };
}
