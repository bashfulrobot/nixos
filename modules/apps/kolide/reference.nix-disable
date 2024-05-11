{ inputs }:
{ pkgs, ... }:
{
  imports = [
    "${inputs.nixpkgs}/nixos/modules/virtualisation/google-compute-image.nix"
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    git
    vim
    pkgs.google-cloud-sdk-gce
    inputs.kolide-launcher
  ];

  services.kolide-launcher = {
    enable = true;
    kolideHostname = "k2device.kolide.com";
    rootDirectory = "/var/kolide-k2/k2device.kolide.com";
    updateChannel = "nightly";
    autoupdateInterval = "2m";
    autoupdaterInitialDelay = "1m";
  };

  environment.variables.EDITOR = "vim";

  nixpkgs.config.allowUnfree = true;
}