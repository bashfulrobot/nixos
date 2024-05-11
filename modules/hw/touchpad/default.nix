{ pkgs, config, lib, ... }:
let cfg = config.hw.touchpad;
in {
  options = {
    hw.touchpad.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the touchpad.";
    };
  };

  config = lib.mkIf cfg.enable {
    # Enable touchpad support (enabled default in most desktopManager).
    services.libinput.enable = true;
  };
}
