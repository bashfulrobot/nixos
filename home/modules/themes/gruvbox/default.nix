{ pkgs, ... }:

with pkgs;
let

  # dracula-gtk = pkgs.callPackage ./gtk { };

in {
  home.packages = with pkgs; [ gruvbox-dark-gtk gruvbox-dark-icons-gtk ];

  # App / Desktop themes
  imports =
    [ ./apps/gitnauro.nix ./apps/alacritty.nix ./settings ];

}
