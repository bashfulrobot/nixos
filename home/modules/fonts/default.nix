{ pkgs, ... }:

with pkgs;
let
  sfpro-font = pkgs.callPackage ./sfpro { };
  sf-mono-liga-font = pkgs.callPackage ./sfpro/liga { };

in {
  home.packages = with pkgs; [

    sfpro-font
    sf-mono-liga-font
    roboto-slab
    fira
    fira-code
    fira-code-symbols
    font-awesome
    comic-mono
    # nerdfonts
    # (nerdfonts.override {
    #   fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" ];
    # })
  ];

}
