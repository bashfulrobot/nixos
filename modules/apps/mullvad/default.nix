{ config, lib, pkgs, ... }:
let cfg = config.apps.mullvad;
in {

  options = {
    apps.mullvad.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable centralised hosts file.";
    };
  };

  config = lib.mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [ mullvad-vpn mullvad-browser ];

    environment.systemPackages = with pkgs;
      [ gnomeExtensions.mullvad-indicator ]; # Mullvad VPN

    services.mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn; # adds gui
    };

    # Mullvad needs resolvd to be enabled

    networking = {
      nameservers = [ "100.100.100.100" "1.1.1.1" "1.0.0.1" ];
      networkmanager.dns = "systemd-resolved";
    };

    services.resolved = {
      enable = true;
      dnssec = "allow-downgrade";
      domains = [ "~." ];
      fallbackDns = [ "8.8.8.8" "9.9.9.9" ];
      dnsovertls = "true";
      # llmnr = "true";
      # extraConfig = ''
      #   Domains=~.
      #   MulticastDNS=true
      # '';
    };
  };
}
