{ user-settings, pkgs, config, lib, ... }:
let
  cfg = config.cli.environment;

in {

  options = {
    cli.environment.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Env Variables.";
    };
  };

# TODO: move variables into individual app modules

  config = lib.mkIf cfg.enable {
  # add environment variables
  home-manager.users."${user-settings.user.username}".home.sessionVariables = {
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    MANROFFOPT = "-c";
    XDG_SESSION_TYPE = "wayland";
    QT_QPA_PLATFORM = "wayland"; # Done in avalanche
    NIXOS_OZONE_WL = 1; # fixed electron apps blurriness # Done in avalanche
    WARP_ENABLE_WAYLAND = 1; # Needed for Warp Terminal to use Wayland
  };
  };
}
