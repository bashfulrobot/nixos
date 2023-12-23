{ pkgs, ... }:

with pkgs;
let dagger = pkgs.callPackage ./build { };

in {
  home.packages = with pkgs; [ dagger ];

}
