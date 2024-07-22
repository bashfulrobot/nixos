{ pkgs }:
pkgs.stdenv.mkDerivation {
  name = "gruvbox-plus";

  src = pkgs.fetchurl {
    url =
      "https://github.com/SylEleuth/gruvbox-plus-icon-pack/releases/download/v4.0/gruvbox-plus-icon-pack-4.0.zip";
    # sha256 = pkgs.lib.fakeSha256;
    sha256 = "sha256-m9bNcPfjaTcyb0XuvfQH0btqqFzPstLABPM8xHF7WBs=";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out
    ${pkgs.unzip}/bin/unzip $src -d $out/
  '';
}
