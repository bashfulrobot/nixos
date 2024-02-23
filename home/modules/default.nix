{ config, inputs, pkgs, secrets, ... }: {

  imports = [
    ./alacritty
    ./bash
    # ./blackbox-terminal
    ./chromium
    ./comics-downloader
    # ./dagger
    ./desktop-files/autostart.nix
    # ./themes/dracula
    ./themes/pop
    ./environment
    ./espanso
    ./firefox
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
