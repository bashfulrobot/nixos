{ config, inputs, pkgs, ... }: {

  imports = [
    ./alacritty
    ./bash
    # ./chromium
    ./desktop-files/tower.nix
    ./environment
    ./espanso
    # ./firefox
    ./fonts
    ./git
    ./go
    ./gpg
    ./kcli
    ./nautilus
    ./ncspot
    ./neovim
    ./npm
    ./python
    ./scripts
    ./ssh
    ./starship
    ./sway
    ./terminal
    ./theme
    ./virter
    ./web-apps
    ./yazi
  ];

}
