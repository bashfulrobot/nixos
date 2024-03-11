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
    # ./themes/gruvbox
    ./themes/adwaita
    ./environment
    ./espanso
    # ./firefox
    ./fish
    ./fonts
    ./git
    ./gnome-web
    ./go
    ./gpg
    ./instruqt
    ./k8sgpt
    ./kubitect
    ./lazygit
    ./linkr
    ./nautilus
    ./ncspot
    #    ./neovim - moved to lunarvim
    ./npm
    ./python
    # ./rio # issues with my nvidia laptop gpu
    ./scripts
    ./seabird
    ./ssh
    # ./starship
    ./sysdig-cli-scanner
    ./terminal
    # ./virter
    ./web-apps
    # ./yazi
  ];

}
