{ config, inputs, pkgs, ... }: {

  imports = [
    ./alacritty
    ./bash
    ./chromium
    ./desktop-files/tower.nix
    ./environment
    ./espanso
    # ./firefox
    # ./flameshot
    ./fonts
    ./git
    ./go
    ./kcli
    ./ncspot
    ./neovim
    ./npm
    ./python
    ./scripts
    ./starship
    ./sway
    ./terminal
    ./theme
    ./virter
    ./web-apps
    ./yazi
  ];

}
