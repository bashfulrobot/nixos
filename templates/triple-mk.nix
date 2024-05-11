{ pkgs, config, lib, ... }:
let cfg = config.SELECT.ME;
in {
  options = {
    SELECT.ME.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable ME";
    };
    SELECT.ME.ANOTHER.OPTION = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable ME";
    };
    SELECT.ME.INLINE.OPTION = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description =
        "Enable ME";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
    ];
    hardware.bluetooth = {
      enable = true;
      settings = {
        General = {
          ControllerMode = lib.mkIf cfg.INLINE.OPTION "bredr";
        };
      };
    };
  } // lib.mkIf cfg.ANOTHER.OPTION {
    # used for solaar

  };
}
