{ lib, pkgs, ... }:
let version = "0.0.1";
in pkgs.stdenv.mkDerivation {
  name = "linkr";
  src = ./linkr;
  phases = [ "installPhase" "patchPhase" ];
  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/linkr
    chmod +x $out/bin/linkr
  '';

  meta = with lib; {
    description = "Linkr- https://linkr.run.";
    maintainers = [ bashfulrobot ];
  };
}
