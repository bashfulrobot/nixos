{ lib, pkgs, ... }:
let version = "0.33.8";
in pkgs.stdenv.mkDerivation {
  name = "comics-downloader";
  src = pkgs.fetchurl {
    url =
      "https://github.com/Girbons/comics-downloader/releases/download/v${version}/comics-downloader";
    sha256 = "sha256-b2nFZSIuEopXKHELbQNyTUJfyNh3ksEUY62G+DY9G7Q=";
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
