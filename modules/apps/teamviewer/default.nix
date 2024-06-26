{ user-settings, pkgs, secrets, config, lib, ... }:
let
  cfg = config.apps.teamviewer;

in {

  options = {
    apps.teamviewer.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable teamviewer.";
    };
  };

  config = lib.mkIf cfg.enable {
    # Enable teamviewer
    services.teamviewer.enable = true;

    environment.systemPackages = with pkgs;
      [
        teamviewer # remote support
      ];

  };
}
