{ lib, pkgs, ... }:
let version = "2133-1c31f0d";
in pkgs.stdenv.mkDerivation {
  name = "instruqt";
  src = pkgs.fetchzip {
    url =
      "https://github.com/instruqt/cli/releases/download/${version}/instruqt-linux.zip";
    sha256 = "sha256-P9HTLlcfNmDhjDOcqvTPoE25D0wJNWBv46G5BlYp3Ak=";
    # stripRoot = false;
  };
  phases = [ "installPhase" "patchPhase" ];
  installPhase = ''
    mkdir -p $out/bin
    cp $src/instruqt $out/bin/instruqt
    chmod +x $out/bin/instruqt
  '';

  meta = with lib; {
    description =
      "Instruqt CLI - https://github.com/instruqt/cli/.";
    maintainers = [ bashfulrobot ];
  };
}
