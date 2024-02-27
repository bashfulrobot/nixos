{ pkgs, ... }:

with pkgs;
let instruqt = pkgs.callPackage ./build { };

in {
  home.packages = with pkgs; [ instruqt ];

}
