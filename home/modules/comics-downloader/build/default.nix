{ lib, pkgs, ... }:
let version = "0.33.9-alpha";
in pkgs.stdenv.mkDerivation {
  name = "comics-downloader";
  src = pkgs.fetchurl {
    url =
      "https://github.com/Girbons/comics-downloader/releases/download/v${version}/comics-downloader-linux-x86-64";
    sha256 = "sha256-zVvKIv8nFm01TRgIgZcCvQ73kBTFfE6LG1UoHB5dxmg=";
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
