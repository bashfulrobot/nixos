{ config, lib, ... }:
let cfg = config.nixcfg.insecure-packages;
in {

  options = {
    nixcfg.insecure-packages.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the use of insecure packages.";
    };
  };

  config = lib.mkIf cfg.enable {

    nixpkgs.config.permittedInsecurePackages =
      # [ "electron-22.3.27" "electron-24.8.6" "openssl-1.1.1v" "openssl-1.1.1w" ];
      [ "electron-25.9.0" ];
  };

}
