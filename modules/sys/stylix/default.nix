# # Keychain set-up

{ user-settings, config, lib, pkgs, ... }:
let cfg = config.sys.stylix;
sf-mono-liga-font = pkgs.callPackage ../fonts/build/sfpro/liga { };

in {

  options = {
    sys.stylix.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Stylix.";
    };
  };

  config = lib.mkIf cfg.enable {

    stylix = {
      enable = true;
      image = ./wallpapers/skullskates.png;
      # one of “stretch”, “fill”, “fit”, “center”, “tile”
      imageScalingMode = "fill";
      polarity = "dark"; # or "light" - forcing dark
      base16Scheme =
        "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 32;
      };
      opacity = {
        applications = 1.0;
        terminal = 1.0;
        desktop = 1.0;
        popups = 1.0;
      };
      fonts = {
        sizes = {
          applications = 12;
          terminal = 20;
          desktop = 12;
          popups = 10;
        };
        serif = {
          package = pkgs.work-sans;
          name = "Work Sans";
        };

        sansSerif = {
          package = pkgs.work-sans;
          name = "Work Sans";
        };

        monospace = {
          package = sf-mono-liga-font;
          name = "Liga SFMono Nerd Font";
        };

        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };
      };

    };
    # home-manager.users."${user-settings.user.username}" = {
    # };
  };
}
