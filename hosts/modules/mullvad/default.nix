{ config, lib, pkgs, ... }:

{
  # environment.systemPackages = with pkgs; [ mullvad-vpn mullvad-browser ];

  environment.systemPackages = with pkgs;
    [ gnomeExtensions.mullvad-indicator ]; # Mullvad VPN

  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn; # adds gui
  };

}
