{ pkgs, config, lib, ... }:
let cfg = config.sys.flatpaks;
in {
  options = {
    sys.flatpaks.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Flatpak Support.";
    };
  };

  config = lib.mkIf cfg.enable {
    # https://github.com/gmodena/nix-flatpak

    # Enable Flatpaks
    services.flatpak.enable = true;

    # enable updates at system activation (default false)
    # services.flatpak.update.onActivation = true;

    # Update flatpaks weekly
    services.flatpak.update.auto = {
      enable = true;
      onCalendar = "weekly"; # Default value
    };

    # By default nix-flatpak will add the flathub remote. Remotes can be manually configured via the services.flatpak.remotes option:
    #   services.flatpak.remotes = [{
    #   name = "flathub-beta"; location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
    # }];

    # services.flatpak.packages = [
      # {
      #   appId = "com.brave.Browser";
      #   origin = "flathub";
      # }
    # ];
  };
}
