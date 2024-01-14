{ config, inputs, pkgs, secrets, ... }: {

  imports = [
    ./alacritty
    ./bash
    ./blackbox-terminal
    ./chromium
    ./dagger
    ./desktop-files/tower.nix
    ./dracula
    ./environment
    ./espanso
    # ./firefox
    ./fish
    ./fonts
    ./git
    ./gitnuro
    ./gnome-web
    ./go
    ./gpg
    ./k8sgpt
    # ./kcli
    ./kubitect
    ./nautilus
    ./ncspot
    #    ./neovim - moved to lunarvim
    ./npm
    ./python
    ./scripts
    ./ssh
    ./starship
    ./sysdig-cli-scanner
    ./terminal
    # ./virter
    ./web-apps
    ./xterm
    # ./yazi
  ];

}
