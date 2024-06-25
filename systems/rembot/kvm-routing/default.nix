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
      externalInterface = "br0"; # Your external interface
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
        # Allow all incoming and outgoing traffic on internal interfaces
          ${
            lib.concatMapStringsSep "\n" (interface: ''
              iptables -A INPUT -i ${interface} -j ACCEPT
              iptables -A OUTPUT -o ${interface} -j ACCEPT
            '') [ "virbr2" "virbr3" "virbr4" "virbr5" "virbr6" "virbr7" ]
          }

          # Allow all incoming and outgoing traffic on the external interface
          iptables -A INPUT -i br0 -j ACCEPT
          iptables -A OUTPUT -o br0 -j ACCEPT

          # Allow inbound traffic to the private subnet on virbr1
          iptables -A FORWARD -d 172.16.150.0/24 -o virbr1 -j ACCEPT
          # Allow outbound traffic from the private subnet on virbr1
          iptables -A FORWARD -s 172.16.150.0/24 -i virbr1 -j ACCEPT
          # Allow traffic between virtual machines on virbr1
          iptables -A FORWARD -i virbr1 -o virbr1 -j ACCEPT
          # Reject everything else on virbr1
          iptables -A FORWARD -i virbr1 -j REJECT --reject-with icmp-port-unreachable
          iptables -A FORWARD -o virbr1 -j REJECT --reject-with icmp-port-unreachable
      '';
    };
  };
}
