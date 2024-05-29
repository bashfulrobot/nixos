{ pkgs, config, lib, inputs, ... }:

let
  cfg = config.desktops.gnome.themes.tokyonight;
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
  tokyonight-gtk-theme-gtk = pkgs.callPackage ./build { };
in {
  options = {
    desktops.gnome.themes.tokyonight.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Gnome tokyonight-gtk Theme.";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users."${username}" = {
      # Getting yaru cursor, sound and icon themes
      home.packages = with pkgs; [ tokyonight-gtk-theme ];
      # https://github.com/kevin-nel/tokyo-night-gtksourceview
      home.file."tokyo-night.xml" = {
        source = ./config/tokyo-night.xml;
        target = ".local/share/gtksourceview-5/styles/tokyo-night.xml";
      };
      home.file."skullskates.png" = {
        source = ./wallpapers/skullskates.png;
        target = ".local/share/backgrounds/skullskates.png";
      };

      dconf.settings = with inputs.home-manager.lib.hm.gvariant; {

        "org/gnome/desktop/interface" = {
          cursor-theme = "Adwaita";
          gtk-theme = "tokyonight-gtk-theme";
          icon-theme = "Adwaita";
        };

        "org/gnome/desktop/sound" = { theme-name = "tokyonight-gtk-theme"; };

        "org/gnome/desktop/background" = {
          picture-uri =
            "file:///home/dustin/.local/share/backgrounds/skullskates.png";
          picture-uri-dark =
            "file:///home/dustin/.local/share/backgrounds/skullskates.png";
          color-shading-type = "solid";
          picture-options = "zoom";
          primary-color = "#000000";
          secondary-color = "#000000";
        };

        "org/gnome/desktop/screensaver" = {
          picture-uri =
            "file:///home/dustin/.local/share/backgrounds/skullskates.png";
          color-shading-type = "solid";
          picture-options = "zoom";
          primary-color = "#000000";
          secondary-color = "#000000";
        };

        "org/gnome/shell/extensions/pop-shell" = {
          hint-color-rgba = "rgb(129, 161, 193)";
        };

        "org/gnome/shell/extensions/user-theme" = {
          name = "tokyonight-gtk-themeic-darker";
        };

      };

      # Add gitnuro theme
      home.file.".config/gitnauro/gitnauro-tokyonight-gtk-theme-dark.json".text =
        ''
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
              background = "#1a1b26";
              foreground = "#a9b1d6";
            };
            cursor = {
              text = "#1a1b26";
              cursor = "#a9b1d6";
            };
            vi_mode_cursor = {
              text = "#1a1b26";
              cursor = "#a9b1d6";
            };
            selection = {
              text = "#a9b1d6";
              background = "#32344a";
            };
            search = {
              matches = {
                foreground = "#32344a";
                background = "#7aa2f7";
              };
              focused_match = {
                foreground = "#32344a";
                background = "#7aa2f7";
              };
            };
            footer_bar = {
              background = "#1a1b26";
              foreground = "#a9b1d6";
            };
            hints = {
              start = {
                foreground = "#1a1b26";
                background = "#7aa2f7";
              };
              end = {
                foreground = "#7aa2f7";
                background = "#1a1b26";
              };
            };
            line_indicator = {
              foreground = "None";
              background = "None";
            };
            normal = {
              black = "#32344a";
              red = "#f7768e";
              green = "#9ece6a";
              yellow = "#e0af68";
              blue = "#7aa2f7";
              magenta = "#ad8ee6";
              cyan = "#449dab";
              white = "#787c99";
            };
            bright = {
              black = "#444b6a";
              red = "#ff7a93";
              green = "#b9f27c";
              yellow = "#ff9e64";
              blue = "#7da6ff";
              magenta = "#bb9af7";
              cyan = "#0db9d7";
              white = "#acb0d0";
            };
            dim = {
              black = "#32344a";
              red = "#f7768e";
              green = "#9ece6a";
              yellow = "#e0af68";
              blue = "#7aa2f7";
              magenta = "#ad8ee6";
              cyan = "#449dab";
              white = "#787c99";
            };
          };
        };
      };

    };

  };
}
