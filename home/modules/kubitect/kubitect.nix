{ lib, pkgs, ... }:
# https://download.sysdig.com/scanning/kubitect/latest_version.txt
pkgs.stdenv.mkDerivation {
  name = "kubitect.tar.gz";
  src = pkgs.fetchzip {
    name = "kubitect";
    url = "https://dl.kubitect.io/linux/amd64/latest?=.tar.gz";
    sha256 = "sha256-sjUQ5PERxDLLFPB1zMLHf06vxHDP+6kJfycps/5IebY=";
    stripRoot = false;
  };
  # Use patchElf to fix dynamic linking
  # https://discourse.nixos.org/t/why-does-this-binary-executable-give-cannot-execute-required-file-not-found/33948/5
  # https://nixos.wiki/wiki/Packaging/Binaries
  # , patchelf --print-needed /etc/profiles/per-user/dustin/bin/kubitect
  # nativeBuildInputs = [ autoPatchelfHook ];
  # Add dependencies here
  # buildInputs = [ pkgs.autoPatchelfHook ];
  phases = [ "installPhase" "patchPhase" ];
  installPhase = ''
    mkdir -p $out/bin
    cp $src/kubitect $out/bin/
    echo "out: $out"
    chmod +x $out/bin/kubitect
  '';

  meta = with lib; {
    description = "kubitect - https://kubitect.io/.";
    maintainers = [ bashfulrobot ];
  };

}
