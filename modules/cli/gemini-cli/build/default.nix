{ lib, pkgs, ... }:
let version = "0.3.0";
in pkgs.stdenv.mkDerivation {
  name = "gemini-cli";
  dontConfigure = true;
  src = pkgs.fetchzip {
    url =
      "https://github.com/reugn/gemini-cli/releases/download/v${version}/gemini_${version}_linux_x86_64.tar.gz";

    sha256 = "sha256-fuKAvM6Wz+piVS5zvYuP6XdbtY3B+oq4QCQsJLtJrVw=";
    stripRoot = false;
  };
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p $out/bin
    cp -r $src/gemini $out/bin/gemini
    chmod +x $out/bin/gemini
  '';

  meta = with lib; {
    description =
      "Google Gemini CLI client";
    maintainers = [ bashfulrobot ];
  };
}
