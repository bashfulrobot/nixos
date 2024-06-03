{ config, pkgs, lib, ... }:
let cfg = config.sys.xdg;
in {

  options = {
    sys.xdg.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable xdg.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [

    ];
    # Enable xdg
    xdg = {
      mime = {
        enable = true;
      };
    };

  };
}
