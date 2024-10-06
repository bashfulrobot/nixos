{ lib, pkgs, ... }:
# https://github.com/dagger/dagger/releases
let version = "0.13.3";
in pkgs.stdenv.mkDerivation {
  name = "dagger";
  dontConfigure = true;
  src = pkgs.fetchzip {
    url =
      "https://github.com/dagger/dagger/releases/download/v${version}/dagger_v${version}_linux_amd64.tar.gz";
    sha256 = "sha256-RipH7gy9IL/xRlZy+KHIz8WfK1vrRUOdmY0G/rbc19c=";
    stripRoot = false;
  };
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p $out/bin
    cp $src/dagger $out/bin/dagger
    chmod +x $out/bin/dagger
  '';

  meta = with lib; {
    description = "dagger - https://docs.dagger.io/.";
    maintainers = [ bashfulrobot ];
  };
}
