{ lib, pkgs, ... }:
# https://github.com/esplus/esplus/releases
let version = "0.3.1";
in pkgs.stdenv.mkDerivation {
  name = "esplus";
  dontConfigure = true;
  src = pkgs.fetchzip {
    url =
      "https://github.com/kpym/esplus/releases/download/v${version}/esplus_${version}_Linux_64bit.tar.gz";
    sha256 = "sha256-RipH7gy9IL/xRlZy+KHIz8WfK1vrRUOdmY0G/rbc19c=";
    stripRoot = false;
  };
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p $out/bin
    cp $src/esplus $out/bin/esplus
    chmod +x $out/bin/esplus
  '';

  meta = with lib; {
    description = "esplus - https://github.com/kpym/esplus.";
    maintainers = [ bashfulrobot ];
  };
}
