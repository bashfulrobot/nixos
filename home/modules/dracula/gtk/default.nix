{ lib, pkgs, ... }:
let
  # rev = "8bfea09aa6f1139479f80358b2e1e5c6dc991a58";
in pkgs.stdenvNoCC.mkDerivation {
  name = "dracula-gtk";
  dontConfigue = true;

  src = pkgs.fetchzip {
    url = "https://github.com/dracula/gtk/archive/master.zip";
    sha256 = "sha256-VY4F1VyqvHnd7fbxHRC8rxoIkW2G+NGulArohGdYgy0=";
    stripRoot = false;
  };

  installPhase = ''
    mkdir -p $out/share/themes/dracula-gtk
    cp -R $src/gtk-master/* $out/share/themes/dracula-gtk
  '';

  meta = with lib; {
    description = "A Dracula GTK derivation.";
    maintainers = [ bashfulrobot ];
  };
}
