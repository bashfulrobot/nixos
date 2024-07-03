# https://crates.io/crates/sway-alttab/1.1.2

# nix-prefetch-url https://github.com/autolyticus/sway-alttab/releases/tag/v1.1.3

{ lib, pkgs, ... }:
pkgs.stdenvNoCC.mkDerivation {
  name = "sway-alttab";
  dontConfigure = true;

  src = pkgs.fetchurl {
    url =
      "https://github.com/autolyticus/sway-alttab/releases/tag/v1.1.3";
    sha256 = "sha256-vnz5N59tTvgU/G1BEabsyFCpA7OdTxpLXrzFN4jhzeg=";
  };

  phases = [ "installPhase" ]; # Removes all phases except installPhase

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/sway-alttab
    chmod +x $out/bin/sway-alttab
  '';

}
