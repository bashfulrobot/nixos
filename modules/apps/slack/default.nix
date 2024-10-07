{ user-settings, pkgs, config, lib, ... }:
let cfg = config.apps.slack;
in {
  options = {
    apps.slack.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Slack Flatpak.";
    };
  };

  config = lib.mkIf cfg.enable {

    services.flatpak.packages = [
      "com.slack.Slack"
    ];
  };
}
