{ pkgs, ... }:

with pkgs;
let

  dracula-gtk = pkgs.callPackage ./gtk { };

in {
  home.packages = with pkgs; [ dracula-gtk ];

}
