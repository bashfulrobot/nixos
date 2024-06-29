{ user-settings, pkgs, config, lib, ... }:
let cfg = config.apps.template-app;

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
    catppuccin.enable = true;
    catppuccin.flavor = "macchiato";

    # environment.systemPackages = with pkgs; [ template-app ];

    home-manager.users."${user-settings.user.username}" = {
      # Home-manager configuration
      wayland.windowManager.sway.catppuccin = {
        enable = true;
        flavor = "macchiato";
      };
    };
  };
}
