{ pkgs, config, lib, ... }:
let
  cfg = config.apps.bluemail;

  bluemail = pkgs.bluemail;

  bluemailWithGPU = pkgs.stdenv.mkDerivation {
  name = "bluemail-with-gpu";
  phases = [ "installPhase" ];
  buildInputs = [ pkgs.makeWrapper ];
  installPhase = ''
    mkdir -p $out/bin
    cp -r ${bluemail}/* $out/
    substituteInPlace $out/share/applications/bluemail.desktop \
      --replace "Exec=bluemail" "Exec=bluemail-gpu"
    makeWrapper ${bluemail}/bin/bluemail $out/bin/bluemail-gpu --add-flags "--in-process-gpu"
  '';
};

  pkgs = import <nixpkgs> { config = { allowUnfree = true; }; };
in {
  options = {
    apps.bluemail.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the bluemail emailclient.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ bluemailWithGPU ];
  };
}
