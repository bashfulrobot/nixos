{ pkgs, ... }:

with pkgs;
let kubitect = pkgs.callPackage ./kubitect.nix { };

in {
  home.packages = with pkgs; [ kubitect ];

}
