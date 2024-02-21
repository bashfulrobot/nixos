{ lib, pkgs, ... }:
let version = "0.0.1";
in pkgs.stdenv.mkDerivation {
  name = "aharoni-font-bold";
  src = ./Aharoni_Bold.ttf;
  phases = [ "installPhase" "patchPhase" ];
  installPhase = ''
    mkdir -p $out/share/fonts
    cp -R $src $out/share/fonts/
  '';

  meta = with lib; {
    description = "aharoni font bold";
    maintainers = [ bashfulrobot ];
  };
}
