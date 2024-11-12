{ lib, pkgs, ... }:
let version = "1.0.8";
in pkgs.stdenv.mkDerivation {
  name = "versitygw";
  dontConfigure = true;

  src = pkgs.fetchzip {
    url =
      "https://github.com/versity/versitygw/releases/download/v${version}/versitygw_v${version}_Linux_x86_64.tar.gz";
    sha256 = "sha256-5LAyeIeNEkdGeJYQ46yx2LiJ+iPhLl8WDA9crWvcwvs=";
    stripRoot = true;
  };
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p $out/bin
    # ls $src > $out/bin/ls.txt
    cp $src/versitygw $out/bin/versitygw
    # chmod +x $out/bin/versitygw
  '';

  meta = with lib; {
    description =
      "versitygw - https://github.com/versity/versitygw";
    maintainers = [ bashfulrobot ];
  };
}
