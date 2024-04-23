{ config, inputs, pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    dconf
    dconf2nix
    gnome.dconf-editor

  ];
  # Enable dconf
  programs.dconf.enable = true;
}
