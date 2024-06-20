{ config, pkgs, lib, ... }:
let cfg = config.archetype.server;
in {

  options = {
    archetype.server.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the server archetype.";
    };
  };

  config = lib.mkIf cfg.enable {

    hw = {

    };

  };
}
