{ config, pkgs, lib, ... }:
let
    cfg = config.programs.firefox;
in
 {
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ firefox ];
  };
}