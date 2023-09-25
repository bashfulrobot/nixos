{ config, pkgs, ... }: {
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enabkle tailscale
  services.tailscale.enable = true;

}
