{ lib, pkgs, ... }:
let
  # rev = "8bfea09aa6f1139479f80358b2e1e5c6dc991a58";
in pkgs.stdenvNoCC.mkDerivation {
  name = "dracula-gtk";
  dontConfigue = true;

  src = pkgs.fetchzip {
    url =
      "https://github.com/bashfulrobot/nixos/raw/main/home/modules/themes/dracula/Dracula.zip";
    sha256 = "sha256-pd3OVLThX1S3RP7HXLAVW5NFRsoi2hYDozF1eTAGLu4=";
    stripRoot = false;
  };

  installPhase = ''
    mkdir -p $out/share/themes/dracula-gtk
    cp -R $src/Dracula/* $out/share/themes/dracula-gtk
    # touch $out/share/themes/dracula-gtk/dk-search
  '';

  meta = with lib; {
    description = "A Dracula GTK derivation.";
    maintainers = [ bashfulrobot ];
  };
}
