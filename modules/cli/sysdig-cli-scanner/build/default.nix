{ lib, pkgs, ... }:
# https://download.sysdig.com/scanning/sysdig-cli-scanner/latest_version.txt
let version = "1.17.0";
in pkgs.stdenv.mkDerivation {
  name = "sysdig-cli-scanner";
  src = pkgs.fetchurl {
    url =
      "https://download.sysdig.com/scanning/bin/sysdig-cli-scanner/${version}/linux/amd64/sysdig-cli-scanner";
    sha256 = "sha256-ls5iOdSTFFj3j1pc9Qd2PYqS9YP/BPQBvvE6tVdR0HU=";
  };
  phases = [ "installPhase" "patchPhase" ];
  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/sysdig-cli-scanner
    chmod +x $out/bin/sysdig-cli-scanner
  '';

  meta = with lib; {
    description =
      "Sysdig CLI Scanner - https://docs.sysdig.com/en/docs/installation/sysdig-secure/install-vulnerability-cli-scanner/.";
    maintainers = [ bashfulrobot ];
  };
}
