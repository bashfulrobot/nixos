{ pkgs, ... }:

with pkgs;
let sysdig-cli-scanner = pkgs.callPackage ./scanner { };

in {
  home.packages = with pkgs; [ sysdig-cli-scanner ];

}
