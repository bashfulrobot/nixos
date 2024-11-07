{ user-settings, pkgs, config, lib, inputs, ... }:

let cfg = config.desktops.gnome.themes.visuals;

in {
  options = {
    desktops.gnome.themes.visuals.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Gnome Visual Settings.";
    };
  };

  config = lib.mkIf cfg.enable {

    home-manager.users."${user-settings.user.username}" = {
      # Getting yaru cursor, sound and icon themes
      home.packages = with pkgs; [
        work-sans
        ];
      home.file."3pio-bender-catppuccin-mocha.png" = {
        source = ../../../../sys/wallpapers/3pio-bender-catppuccin-mocha.png;
        target = ".local/share/backgrounds/3pio-bender-catppuccin-mocha.png";
      };

      dconf.settings = with inputs.home-manager.lib.hm.gvariant; {

        "org/gnome/desktop/interface" = {
          # Disable (fonts) when using Stylix
          font-name = "Work Sans 12";
          document-font-name = "Work Sans 12";
          monospace-font-name = "Source Code Pro 10";
          font-hinting = "full";
          font-antialiasing = "rgba";
        };
        "org/gnome/desktop/wm/preferences" = {
          # button-layout = "appmenu:minimize,maximize,close";
          # button-layout = "";
          num-workspaces = 4;

        };

        # "org/gnome/desktop/sound" = { theme-name = "tokyonight-gtk-theme"; };

        # Disable when using Stylix
        "org/gnome/desktop/background" = {
          picture-uri =
            "file:///home/dustin/.local/share/backgrounds/3pio-bender-catppuccin-mocha.png";
          picture-uri-dark =
            "file:///home/dustin/.local/share/backgrounds/3pio-bender-catppuccin-mocha.png";
          color-shading-type = "solid";
          picture-options = "zoom";
          primary-color = "#000000";
          secondary-color = "#000000";
        };

        "org/gnome/desktop/screensaver" = {
          picture-uri =
            "file:///home/dustin/.local/share/backgrounds/3pio-bender-catppuccin-mocha.png";
          # color-shading-type = "solid";
          picture-options = "zoom";
          # primary-color = "#000000";
          # secondary-color = "#000000";
        };

      };

    };

  };
}
