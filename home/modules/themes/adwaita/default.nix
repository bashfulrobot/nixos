{ pkgs, ... }:

with pkgs;
let

  # dracula-gtk = pkgs.callPackage ./gtk { };

in {
  # Getting yaru cursor, sound and icon themes
  home.packages = with pkgs; [ yaru-theme ];

  # App / Desktop themes
  imports =
    [ ./apps/gitnauro.nix ./apps/alacritty.nix ./settings ];

}
