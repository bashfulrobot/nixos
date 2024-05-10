{ config, pkgs, lib, ... }:
let cfg = config.suites.media;
in {

  options = {
    suites.media.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the media suite.";
    };
  };

  config = lib.mkIf cfg.enable {

    cli = { spotify-player.enable = true; };

  };
}
