{ config, inputs, pkgs, secrets, ... }: {

  imports = [
    ./alacritty
    ./bash
    ./blackbox-terminal
    ./chromium
    # ./dagger
    ./desktop-files/tower.nix
    # ./themes/dracula
    ./environment
    ./espanso
    # ./firefox
    ./fish
    ./fonts
    ./git
    ./gnome-web
    ./go
    ./gpg
    ./k8sgpt
    ./kubitect
    ./lazygit
    ./linkr
    ./nautilus
    ./ncspot
    #    ./neovim - moved to lunarvim
    ./npm
    ./python
    ./scripts
    ./ssh
    # ./starship
    ./sysdig-cli-scanner
    ./terminal
    # ./virter
    ./web-apps
    # ./yazi
  ];

}
