{ pkgs, ... }:

with pkgs;
let kubitect = pkgs.callPackage ./kubitect.nix { };

in {
  home.packages = with pkgs; [
    kubitect
    # dependencies
    virtualenv
    # git - installed globally
    # python - installed globally
  ];

}
