{ user-settings, pkgs, config, lib, ... }:
let
    cfg = config.apps.brave;
in
 {

  options = {
    apps.brave.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the brave browser.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ brave ];
  };
}