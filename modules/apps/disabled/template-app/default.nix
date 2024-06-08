# =============================================================================
# MODULE: Template Application Configuration
# =============================================================================
#
# OVERVIEW
# --------
# This Nix file serves as a template for configuring applications.
# It provides a placeholder `apps.template-app.enable` option to enable or disable the application.
# Replace `template-app` with the actual name of your application.
#
# DETAILS
# -------
# When the application is enabled, it is added to the system packages.
# The username for the home-manager configuration is determined based on the environment variables `SUDO_USER` and `USER`.
# If `SUDO_USER` is not empty, it is used as the username; otherwise, `USER` is used.
#
# USAGE
# -----
# Use this file as a base to create configuration files for other applications.
# Note - modules/apps/syncthing/default.nix is a good example with multiple options, and the use of `mkMerge` to combine them.
# Without `mkMerge`, the last option will override the previous ones.
#
# =============================================================================

{ user-settings, pkgs, config, lib, ... }:
let
  cfg = config.apps.template-app;

in {

  options = {
    apps.template-app.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the template-app application.";
    };
  };

  config = lib.mkIf cfg.enable {

    # Regular nix configuration
    environment.systemPackages = with pkgs; [ template-app ];

    home-manager.users."${user-settings.user.username}" = {
      # Home-manager configuration
     };
  };
}
