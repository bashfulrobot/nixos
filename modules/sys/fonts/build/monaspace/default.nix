{ lib, pkgs, ... }:
let version = "1.101";
in pkgs.stdenvNoCC.mkDerivation {
  name = "monaspace-font";
  dontConfigure = true;

  src = pkgs.fetchzip {
    url =
      "https://github.com/githubnext/monaspace/releases/download/v${version}/monaspace-v${version}.zip";
    sha256 = "sha256-H8NOS+pVkrY9DofuJhPR2OlzkF4fMdmP2zfDBfrk83A=";
    stripRoot = true;
  };

  installPhase = ''
    # Copy commands from the official linux install script modified for nix
    mkdir -p $out/share/fonts
    cp $src/monaspace-v${version}/fonts/variable/* $out/share/fonts/
    cp $src/monaspace-v${version}/fonts/otf/* $out/share/fonts/
  '';

  meta = with lib; {
    description =
      "A monaspace font derivation. https://github.com/githubnext/monaspace#monaspace";
    maintainers = [ bashfulrobot ];
  };
}
