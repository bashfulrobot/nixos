{ lib, pkgs, ... }:

let version = "0.1.2";
in pkgs.stdenv.mkDerivation {
  name = "seabird";
  src = pkgs.fetchzip {

    url =
      "https://github.com/getseabird/seabird/releases/download/v${version}/seabird_linux_amd64.tar.gz";

    sha256 = "sha256-sjUQ5PERxDLLFPB1zMLHf06vxHDP+6kJfycps/5IebY=";
    stripRoot = false;
  };

  # buildInputs = [ pkgs.autoPatchelfHook ];
  phases = [ "installPhase" "patchPhase" ];
  installPhase = ''
    mkdir -p $out/bin
    cp $src/seabird $out/bin/
    echo "out: $out"
    chmod +x $out/bin/seabird
  '';

  meta = with lib; {
    description = "seabird.";
    maintainers = [ bashfulrobot ];
  };

}
