{ lib, pkgs, ... }:
let version = "1.000";
in pkgs.stdenvNoCC.mkDerivation {
  name = "numix-black-colors-gtk-theme";
  dontConfigure = true;

  src = pkgs.fetchzip {
    url =
      "https://github.com/rtlewis1/GTK/archive/refs/heads/Numix-BLACK-Colors-Desktop.zip";
    sha256 = "sha256-H8NOS+pVkrY9DofuJhPR2OlzkF4fMdmP2zfDBfrk83A=";
    stripRoot = true;
  };

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/themes
    ls -al
    cp -a Numix* $out/share/themes
    rm $out/share/themes/*/{LICENSE,README.md}
    runHook postInstall
  '';

  meta = with lib; {
    description =
      "A oled gtk theme based on the Numix theme.";
    maintainers = [ bashfulrobot ];
  };
}
