{ lib, pkgs, ... }:
let version = "0.0.1";
in pkgs.stdenv.mkDerivation {
  name = "inter-font";
  src = ./src/inter;
  phases = [ "installPhase" "patchPhase" ];
  installPhase = ''
    mkdir -p $out/share/fonts
    cp -R $src $out/share/fonts/
  '';

  meta = with lib; {
    description = "inter font";
    maintainers = [ bashfulrobot ];
  };
}
