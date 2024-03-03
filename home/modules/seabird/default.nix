{ pkgs, ... }:

with pkgs;
let seabird = pkgs.callPackage ./seabird.nix { };

in {
  home.packages = with pkgs; [
    seabird
  ];

}
