{ lib, stdenv }:

stdenv.mkDerivation {
  name = "plymouth-icon";
  version = "1.0";

  src = ./Sysdig.png;

  unpackPhase = "true"; # Skip the unpack phase

  installPhase = ''
    mkdir -p $out/share/icons/hicolor/48x48/apps
    cp $src $out/share/icons/hicolor/48x48/apps/Sysdig.png
  '';

  meta = {
    description = "Icon for Plymouth";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ bashfulrobot ];
  };
}