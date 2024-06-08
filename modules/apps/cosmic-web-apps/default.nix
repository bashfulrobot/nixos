{ user-settings, pkgs, config, lib, ... }:
let cfg = config.apps.cosmic-web-apps;
in {
  options = {
    apps.cosmic-web-apps.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable cosmic-web-apps app.";
    };
  };

  config = lib.mkIf cfg.enable {

    services.flatpak.packages = [
      "io.github.elevenhsoft.WebApps"
       #  Allow you to simply create web applications from given URL working inside separate window of your browser of choice.
      # May need to move FF to flatpak to get this to work
      # Or use an alternate brower like GNOME Web
    ];
  };
}
