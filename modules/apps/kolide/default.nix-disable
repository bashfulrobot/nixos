{ pkgs, config, inputs, lib, secrets, ... }:
let cfg = config.apps.kolide;
in {

  options = {
    apps.kolide.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable kolide.";
    };
  };

  config = lib.mkIf cfg.enable {
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;

    # Install necessary packages
    environment.systemPackages = [ inputs.kolide-launcher ];

    environment.etc."kolide-k2/secret" = {
      mode = "0600";
      text = "${secrets.kolide.secret}";
    };

    services.kolide-launcher = {
      enable = true;
      rootDirectory = "/var/kolide-k2/evo";
      # updateChannel = "nightly";
      updateChannel = "stable";
      # autoupdateInterval = "2m"; # default is 1h
      # autoupdaterInitialDelay = "1m"; # default is 1h
    };
  };
}
