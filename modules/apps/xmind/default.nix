{ pkgs, config, lib, ... }:
let cfg = config.apps.xmind;
in {
  options = {
    apps.xmind.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Xmind.";
    };
  };

  config = lib.mkIf cfg.enable {

    services.flatpak.packages = [
      "net.xmind.XMind" # Mindmapping
    ];
  };
}
