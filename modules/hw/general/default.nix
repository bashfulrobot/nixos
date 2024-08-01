{ pkgs, config, lib, ... }:
let cfg = config.hw.general;
in {

  options = {
    hw.general.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable general shared hardware settings.";
    };
  };

  config = lib.mkIf cfg.enable {
    # hardware = {

    # };
  };
}
