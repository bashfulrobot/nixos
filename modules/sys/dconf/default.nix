{ config, pkgs, lib, ... }:
let cfg = config.sys.dconf;
in {

  options = {
    sys.dconf.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable dconf.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      dconf
      dconf2nix
      dconf-editor

    ];
    # Enable dconf
    programs.dconf.enable = true;
  };
}
