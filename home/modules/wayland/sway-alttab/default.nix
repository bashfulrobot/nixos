{ pkgs, ... }:

with pkgs;
let
  sway-alttab = pkgs.callPackage ./alttab { };

in {
  home.packages = with pkgs; [

    sway-alttab
  ];

}
