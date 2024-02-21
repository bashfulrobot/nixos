{ pkgs, ... }:

with pkgs;
let
  sfpro-font = pkgs.callPackage ./sfpro { };
  sf-mono-liga-font = pkgs.callPackage ./sfpro/liga { };
  aharoni-font = pkgs.callPackage ./aharoni/aharoni.nix { };
  aharoni-font-bold = pkgs.callPackage ./aharoni/aharoni-bold.nix { };

in {
  home.packages = with pkgs; [
    aharoni-font
    aharoni-font-bold
    sfpro-font
    sf-mono-liga-font
    roboto-slab
    fira
    fira-code
    fira-code-symbols
    font-awesome
    cantarell-fonts
    # comic-mono
    victor-mono
    # Meslo Nerd Font patched for Powerlevel10k
    meslo-lgs-nf
    # Helvetica for Camino
    helvetica-neue-lt-std
    # nerdfonts
    # (nerdfonts.override {
    #   fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" "SourceCodePro" ];
    # })
  ];

}
