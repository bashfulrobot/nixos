{ pkgs, config, lib, ... }:
let cfg = config.SELECT.ME;
in {
  options = {
    SELECT.ME.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable ME.";
    };
  };

  config = lib.mkIf cfg.enable {

  };
}
