{ pkgs, secrets, ... }:
let
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {

   # Enable Tailscale
  services.tailscale.enable = true;

  home-manager.users."${username}" = {

    home.packages = with pkgs;
      [
        tailscale # zero-config VPN
      ];

  };
}
