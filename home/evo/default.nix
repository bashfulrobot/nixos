{ config, inputs, pkgs, secrets, ... }: {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "dustin";
  home.homeDirectory = "/home/dustin";

  imports = [
    ../modules
    ../modules/gnome
    ./hardware.nix
    ../modules/desktop-files/laptop.nix
    ../modules/desktop-files/laptop-autostart.nix
  ];

  fonts.fontconfig.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
