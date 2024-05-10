{ pkgs, config, lib, ... }:
let
    cfg = config.apps.firefox;
in
 {

  options = {
    apps.firefox.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the Firefox browser.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ firefox ];
  };
}