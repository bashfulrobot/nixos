{ user-settings, catppuccin, pkgs, config, lib, ... }:
let cfg = config.desktops.sway.themes.catppuccin;

in {

  options = {
    desktops.sway.themes.catppuccin.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the catppuccin theme for sway.";
    };
  };

  config = lib.mkIf cfg.enable {

    # Regular nix configuration
    catppuccin = {
      enable = true;
      flavor = "macchiato";
      # “blue”, “flamingo”, “green”, “lavender”, “maroon”, “mauve”, “peach”, “pink”, “red”, “rosewater”, “sapphire”, “sky”, “teal”, “yellow”
      accent = "mauve";

    };

    boot.loader.grub.catppuccin = {
      enable = true;
      flavor = "macchiato";

    };

    services.displayManager = {
      sddm.catppuccin = {
        enable = true;
        flavor = "macchiato";
        background = "~/Pictures/wallpapers/skullskates.png";
        font = "Work Sans";
        fontSize = "18";
      };
    };

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
