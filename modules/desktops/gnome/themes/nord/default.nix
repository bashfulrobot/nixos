{ user-settings, pkgs, config, lib, inputs, ... }:

let
  cfg = config.desktops.gnome.themes.nord;

in {
  options = {
    desktops.gnome.themes.nord.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Gnome Nord Theme.";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users."${user-settings.user.username}" = {
      # Getting yaru cursor, sound and icon themes
      home.packages = with pkgs; [
        nordic
        nordzy-icon-theme
        nordzy-cursor-theme
        papirus-nord
      ];

      home.file."nord-wallpaper.png" = {
        source = ./wallpapers/nord-wallpaper.png;
        target = ".local/share/backgrounds/nord-wallpaper.png";
      };

      # If you use 1 pixel border the theme's shadow can leak underneath, also sway's border can only be without border radius
      home.file."gtk-3.0/gtk.css".text = ''
        /** Some apps use titlebar class and some window */
        .titlebar,
        window {
          border-radius: 0;
          box-shadow: none;
        }

        /** also remove shadows */
        decoration {
          box-shadow: none;
        }

        decoration:backdrop {
          box-shadow: none;
        }
      '';

      dconf.settings = with inputs.home-manager.lib.hm.gvariant; {

        "org/gnome/desktop/interface" = {
          cursor-theme = "Nordzy-cursors";
          gtk-theme = "Nordic-darker";
          icon-theme = "Nordzy-dark";
        };

        "org/gnome/desktop/sound" = { theme-name = "Yaru"; };

        "org/gnome/desktop/background" = {
          picture-uri =
            "file:///home/dustin/.local/share/backgrounds/nord-wallpaper.png";
          picture-uri-dark =
            "file:///home/dustin/.local/share/backgrounds/nord-wallpaper.png";
          color-shading-type = "solid";
          picture-options = "zoom";
          primary-color = "#000000";
          secondary-color = "#000000";
        };

        "org/gnome/desktop/screensaver" = {
          picture-uri =
            "file:///home/dustin/.local/share/backgrounds/nord-wallpaper.png";
          color-shading-type = "solid";
          picture-options = "zoom";
          primary-color = "#000000";
          secondary-color = "#000000";
        };

        "org/gnome/shell/extensions/pop-shell" = {
          hint-color-rgba = "rgb(129, 161, 193)";
        };

        "org/gnome/shell/extensions/user-theme" = { name = "Nordic-darker"; };

      };

      # Add gitnuro theme
      home.file.".config/gitnauro/gitnauro-nord-dark.json".text = ''
           {
            "primary": "#88C0D0",
            "primaryVariant": "#81A1C1",
            "onPrimary": "#2E3440",
            "secondary": "#8FBCBB",
            "onBackground": "#D8DEE9",
            "onBackgroundSecondary": "#E5E9F0",
            "error": "#BF616A",
            "onError": "#D8DEE9",
            "background": "#2E3440",
            "backgroundSelected": "#3B4252",
            "surface": "#434C5E",
            "secondarySurface": "#4C566A",
            "tertiarySurface": "#5E81AC",
            "addFile": "#A3BE8C",
            "deletedFile": "#BF616A",
            "modifiedFile": "#D08770",
            "conflictingFile": "#EBCB8B",
            "dialogOverlay": "#000000",
            "normalScrollbar": "#4C566A",
            "hoverScrollbar": "#D08770",
            "diffLineAdded": "#A3BE8C",
            "diffLineRemoved": "#BF616A",
            "isLight": false
        }
      '';

      # Alactrity theme
      programs.alacritty = {
        settings = {
          colors = {
            primary = {
              background = "#2E3440";
              foreground = "#D8DEE9";
            };
            cursor = {
              text = "#2E3440";
              cursor = "#D8DEE9";
            };
            vi_mode_cursor = {
              text = "#2E3440";
              cursor = "#D8DEE9";
            };
            selection = {
              text = "#D8DEE9";
              background = "#3B4252";
            };
            search = {
              matches = {
                foreground = "#3B4252";
                background = "#A3BE8C";
              };
              focused_match = {
                foreground = "#3B4252";
                background = "#BF616A";
              };
            };
            footer_bar = {
              background = "#2E3440";
              foreground = "#D8DEE9";
            };
            hints = {
              start = {
                foreground = "#2E3440";
                background = "#A3BE8C";
              };
              end = {
                foreground = "#A3BE8C";
                background = "#2E3440";
              };
            };
            line_indicator = {
              foreground = "None";
              background = "None";
            };
            normal = {
              black = "#3B4252";
              red = "#BF616A";
              green = "#A3BE8C";
              yellow = "#EBCB8B";
              blue = "#81A1C1";
              magenta = "#B48EAD";
              cyan = "#88C0D0";
              white = "#E5E9F0";
            };
            bright = {
              black = "#4C566A";
              red = "#BF616A";
              green = "#A3BE8C";
              yellow = "#EBCB8B";
              blue = "#81A1C1";
              magenta = "#B48EAD";
              cyan = "#8FBCBB";
              white = "#ECEFF4";
            };
            dim = {
              black = "#2E3440";
              red = "#BF616A";
              green = "#A3BE8C";
              yellow = "#D08770";
              blue = "#5E81AC";
              magenta = "#B48EAD";
              cyan = "#88C0D0";
              white = "#D8DEE9";
            };
          };
        };
      };

    };

  };
}
