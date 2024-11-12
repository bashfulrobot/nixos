{ user-settings, config, pkgs, lib, ... }:
let
    cfg = config.apps.todoist;
in
 {

  options = {
    apps.todoist.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the todoist client.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ unstable.todoist-electron ];
  };
}