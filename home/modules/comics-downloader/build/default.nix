{ lib, pkgs, ... }:
let version = "0.33.8";
in pkgs.stdenv.mkDerivation {
  name = "comics-downloader";
  src = pkgs.fetchurl {
    url =
      "https://github.com/Girbons/comics-downloader/releases/download/v${version}/comics-downloader";
    sha256 = "sha256-bAIs/kF+C7UJukoPp8Vp2N1Jlr4WANnojKkUIl5+P1A=";
  };
  phases = [ "installPhase" "patchPhase" ];
  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/comics-downloader
    chmod +x $out/bin/comics-downloader
  '';

  meta = with lib; {
    description =
      "Comics Downloader - https://github.com/Girbons/comics-downloader.";
    maintainers = [ bashfulrobot ];
  };
}
