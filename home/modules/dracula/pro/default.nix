# dracula-theme.nix
{ lib, stdenvNoCC }:

stdenvNoCC.mkDerivation {
  name = "dracula-gtk-theme";
  src = ./dracula.zip; # Or path to your ZIP file

  installPhase = ''
    mkdir -p $out/share/themes/Dracula
    cp -R $src/* $out/share/themes/Dracula
  '';

  meta = with lib; {
    description = "Dracula GTK theme";
    maintainers = [ "dustin.krysak" ];
  };
}
