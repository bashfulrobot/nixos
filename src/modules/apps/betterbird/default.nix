{ config, pkgs, lib, ... }:
let
    cfg = config.apps.betterbird;
in
 {

  options = {
    apps.betterbird.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the betterbird mail client.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ betterbird ];
  };
}