{ pkgs, ... }:

with pkgs;
let

  # dracula-gtk = pkgs.callPackage ./gtk { };

in {
  # Getting yaru cursor, sound and icon themes
  home.packages = with pkgs; [ nordic nordzy-icon-theme nordzy-cursor-theme papirus-nord ];

  # App / Desktop themes
  imports =
    [ ./apps/gitnauro.nix ./apps/alacritty.nix ./settings ];

}
