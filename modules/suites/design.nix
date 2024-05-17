# to be built
{ config, pkgs, lib, ... }:
let cfg = config.suites.design;
in {

  options = {
    suites.design.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the design suite.";
    };
  };

  config = lib.mkIf cfg.enable {

    cli = { spotify-player.enable = true; };
    # apps = {
    #   obs.enable = true;
    #   delfin.enable = true;
    # };

  };
}
