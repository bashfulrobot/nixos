{ pkgs, ... }:

with pkgs;
let comics-downloader = pkgs.callPackage ./build { };

in {
  home.packages = with pkgs; [ comics-downloader ];

}
