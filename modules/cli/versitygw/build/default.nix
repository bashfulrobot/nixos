{ lib, pkgs, ... }:
let version = "1.0.8";
in pkgs.stdenv.mkDerivation {
  name = "versitygw";
  dontConfigure = true;
  stripRoot = false;
  src = pkgs.fetchurl {
    url =
      "https://github.com/versity/versitygw/releases/download/v${version}/versitygw_v${version}_Linux_x86_64.tar.gz";
    sha256 = "sha256-eQOTh0Ybz1drtj1WLS9RXBI+O3fxbYGWUSI3TMGsTjE=";
  };
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p $out/bin
    cp $src/versitygw $out/bin/versitygw
    chmod +x $out/bin/versitygw
  '';

  meta = with lib; {
    description =
      "versitygw - https://github.com/versity/versitygw";
    maintainers = [ bashfulrobot ];
  };
}
