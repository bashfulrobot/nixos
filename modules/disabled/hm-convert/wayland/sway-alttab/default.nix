{ pkgs, ... }:

with pkgs;
let
  sway-alttab = pkgs.callPackage ./build { };

in {
  home.packages = with pkgs; [

    sway-alttab
  ];

}
