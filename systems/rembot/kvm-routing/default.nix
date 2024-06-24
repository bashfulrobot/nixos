{ config, pkgs, lib, inputs, ... }: {
  boot.kernel.sysctl = {
    # Enable IP forwarding
    "net.ipv4.ip_forward" = 1;
    # controls whether packets traversing a Linux bridge will be passed through iptables' FORWARD chain. When set to 1 (enabled), it allows iptables rules to affect bridged (as opposed to just routed) traffic.
    "net.bridge.bridge-nf-call-iptables" = 1;
  };

  networking = {
    nat = {
      enable = true;
      externalInterface = "br0"; # Your external interface
      # Note
      # - for every routed network created in Terrraform, you need to add a new internal interface here
      # - and a static route needs to be added to the LAN router for the new network
      internalInterfaces = [ "virbr1" "virbr2" "virbr3" "virbr4" "virbr5" "virbr6" "virbr7" ]; # Your KVM bridge interface
    };
    firewall = {
      enable = true;
      allowedTCPPorts = [ ]; # Empty since we're allowing all traffic
      allowedUDPPorts = [ ]; # Empty since we're allowing all traffic
      extraCommands = ''
        # Allow all incoming and outgoing traffic on internal LAN interface
        # iptables -A INPUT -i virbr3 -j ACCEPT
        # iptables -A OUTPUT -o virbr3 -j ACCEPT
      '';
    };
  };
}
