{ pkgs, ... }:

with pkgs;
let

  # dracula-gtk = pkgs.callPackage ./gtk { };

in {
  home.packages = with pkgs; [ pop-gtk-theme pop-icon-theme ];

  # App / Desktop themes
  imports = [ ./apps/gitnauro.nix ./apps/alacritty.nix ./settings ];

}
