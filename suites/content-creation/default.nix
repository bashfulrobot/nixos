{ config, pkgs, lib, ... }:
let cfg = config.suites.content-creation;
in {

  options = {
    suites.content-creation.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Design, and media tools.";
    };
  };

  config = lib.mkIf cfg.enable {

    apps = {
      obs.enable = true;
    };
    environment.systemPackages = with pkgs; [
      # --- Visuals
      gimp-with-plugins # image editor
      inkscape-with-extensions # vector graphics editor


    ];
  };
}
