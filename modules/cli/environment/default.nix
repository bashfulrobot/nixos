{ pkgs, config, lib, ... }:
let
  cfg = config.cli.environment;
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
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
  home-manager.users."${username}".home.sessionVariables = {
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    MANROFFOPT = "-c";
    XDG_CURRENT_DESKTOP = "gnome";
    XDG_SESSION_TYPE = "wayland";
    QT_QPA_PLATFORM = "wayland";
    NIXOS_OZONE_WL = 1; # fixed electron apps blurriness
    WARP_ENABLE_WAYLAND = 1; # Needed for Warp Terminal to use Wayland
  };
  };
}
