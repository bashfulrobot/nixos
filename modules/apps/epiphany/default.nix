{ user-settings, lib, inputs, pkgs, config, ... }:
let
  cfg = config.apps.epiphany;


in {
  options = {
    apps.epiphany.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable gnome-web (Epiphany) browser.";
    };

    apps.epiphany.useFlatpak = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Use Flatpak for installing gnome-web (Epiphany) browser.";
    };
  };

  config = lib.mkIf cfg.enable {

    # use regular package
    environment.systemPackages = lib.mkIf (!cfg.useFlatpak) [ pkgs.epiphany ];

    # use flatpak package
    services.flatpak.packages = lib.mkIf cfg.useFlatpak [
      "org.gnome.Epiphany"
      #  Allow you to simply create web applications from given URL working inside separate window of your browser of choice.
      # May need to move FF to flatpak to get this to work
      # Or use an alternate brower like GNOME Web
    ];

    home-manager.users."${user-settings.user.username}" = {
      dconf.settings = with inputs.home-manager.lib.hm.gvariant; {

        "org/gnome/epiphany/web" = {
          enable-webextensions = true;
          ask-on-download = true;
          enable-mouse-gestures = true;
        };
        "org/gnome/epiphany" = {
          ask-for-default = false;
          default-search-engine = "Google";
          homepage-url = "https://google.ca/";
        };
      };
    };
  };
}
