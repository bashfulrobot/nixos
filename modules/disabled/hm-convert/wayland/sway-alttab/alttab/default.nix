# https://crates.io/crates/sway-alttab/1.1.2

# nix-prefetch-url https://github.com/ereduled/sway-alttab/releases/download/v1.1.3/sway-alttab

{ lib, pkgs, ... }:
pkgs.stdenvNoCC.mkDerivation {
  name = "sway-alttab";
  dontConfigue = true;

  src = pkgs.fetchurl {
    url =
      "https://github.com/ereduled/sway-alttab/releases/download/v1.1.3/sway-alttab";
    sha256 = "1vf0bk7i6nrs2lrxcyhq1rsypsypcci8mc7bcg0439crq5xa29qj";
  };

  phases = [ "installPhase" ]; # Removes all phases except installPhase

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/sway-alttab
    chmod +x $out/bin/sway-alttab
  '';

}
