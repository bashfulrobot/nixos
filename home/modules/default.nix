{ config, inputs, pkgs, secrets, ... }: {

  imports = [
    ./alacritty
    ./bash
    ./chromium
    ./desktop-files/tower.nix
    ./dracula
    ./environment
    ./espanso
    ./firefox
    ./fish
    ./fonts
    ./git
    ./go
    ./gpg
    ./kcli
    ./kubitect
    ./nautilus
    ./ncspot
    #    ./neovim - moved to lunarvim
    ./npm
    ./python
    ./scripts
    ./ssh
    ./starship
    # ./sysdig-cli-scanner
    ./terminal
    ./virter
    ./web-apps
    ./xterm
    # ./yazi
  ];

}
