{ user-settings, pkgs, config, lib, inputs, ... }:

let cfg = config.desktops.gnome.themes.tokyonight;

in {
  options = {
    desktops.gnome.themes.tokyonight.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Gnome tokyonight-gtk Theme.";
    };
  };

  config = lib.mkIf cfg.enable {

    home-manager.users."${user-settings.user.username}" = {
      # Getting yaru cursor, sound and icon themes
      home.packages = with pkgs; [ tokyonight-gtk-theme work-sans ];
      # https://github.com/kevin-nel/tokyo-night-gtksourceview
      home.file."tokyo-night.xml" = {
        source = ./config/tokyo-night.xml;
        target = ".local/share/gtksourceview-5/styles/tokyo-night.xml";
      };
      home.file."skullskates.png" = {
        source = ./wallpapers/skullskates.png;
        target = ".local/share/backgrounds/skullskates.png";
      };

      # done in stylix
      # If you use 1 pixel border the theme's shadow can leak underneath, also sway's border can only be without border radius
      # home.file.".config/gtk-3.0/gtk.css".text = ''
      #   /** Some apps use titlebar class and some window */
      #   .titlebar,
      #   window {
      #     border-radius: 0;
      #     box-shadow: none;
      #   }

      #   /** also remove shadows */
      #   decoration {
      #     box-shadow: none;
      #   }

      #   decoration:backdrop {
      #     box-shadow: none;
      #   }
      # '';

      dconf.settings = with inputs.home-manager.lib.hm.gvariant; {

        "org/gnome/desktop/interface" = {
          # set in stylix
          # document-font-name = "Work Sans 12";
          font-name = "Work Sans 12";
          # set in stylix
          # monospace-font-name = "Victor Mono 13";
          # set in stylix
          # cursor-theme = "Adwaita";
          # set in stylix
          # gtk-theme = "Tokyonight-Dark";
          icon-theme = "Tokyonight-Dark";
        };
        "org/gnome/extensions/appindicator" = {
          icon-saturation = 0.9999999999999999;

        };

        "org/gnome/desktop/wm/preferences" = {
          # button-layout = "appmenu:minimize,maximize,close";
          button-layout = "";
          num-workspaces = 4;
          theme = "Tokyonight-Dark";

        };

        # "org/gnome/desktop/sound" = { theme-name = "tokyonight-gtk-theme"; };

        "org/gnome/desktop/background" = {
          # Disabled and set in stylix
          # picture-uri =
          #   "file:///home/dustin/.local/share/backgrounds/skullskates.png";
          # picture-uri-dark =
          #   "file:///home/dustin/.local/share/backgrounds/skullskates.png";
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
          active-hint = false;
          hint-color-rgba = "rgb(122, 162, 247)";
          gap-inner = 6;
          gap-outer = 6;
          active-hint-border-radius = 10;
          show-title = false;
          show-skip-taskbar = false;
        };

        # set in stylix
        # "org/gnome/shell/extensions/user-theme" = { name = "Tokyonight-Dark"; };

      };

      # set in stylix
      # Add gitnuro theme
      # home.file.".config/gitnauro/gitnauro-tokyonight-gtk-theme-dark.json".text =
      #   ''
      #     {
      #     "primary": "#7aa2f7",
      #     "primaryVariant": "#32344a",
      #     "onPrimary": "#1a1b26",
      #     "secondary": "#9ece6a",
      #     "onBackground": "#a9b1d6",
      #     "onBackgroundSecondary": "#787c99",
      #     "error": "#f7768e",
      #     "onError": "#a9b1d6",
      #     "background": "#1a1b26",
      #     "backgroundSelected": "#32344a",
      #     "surface": "#444b6a",
      #     "secondarySurface": "#32344a",
      #     "tertiarySurface": "#7aa2f7",
      #     "addFile": "#9ece6a",
      #     "deletedFile": "#f7768e",
      #     "modifiedFile": "#e0af68",
      #     "conflictingFile": "#ff9e64",
      #     "dialogOverlay": "#1a1b26",
      #     "normalScrollbar": "#32344a",
      #     "hoverScrollbar": "#e0af68",
      #     "diffLineAdded": "#9ece6a",
      #     "diffLineRemoved": "#f7768e",
      #     "isLight": false
      #     }
      #   '';

      # set in stylix
      # Alactrity theme
      # programs.alacritty = {
      #   settings = {
      #     colors = {
      #       primary = {
      #         background = "#1a1b26";
      #         foreground = "#a9b1d6";
      #       };
      #       cursor = {
      #         text = "#1a1b26";
      #         cursor = "#a9b1d6";
      #       };
      #       vi_mode_cursor = {
      #         text = "#1a1b26";
      #         cursor = "#a9b1d6";
      #       };
      #       selection = {
      #         text = "#a9b1d6";
      #         background = "#32344a";
      #       };
      #       search = {
      #         matches = {
      #           foreground = "#32344a";
      #           background = "#7aa2f7";
      #         };
      #         focused_match = {
      #           foreground = "#32344a";
      #           background = "#7aa2f7";
      #         };
      #       };
      #       footer_bar = {
      #         background = "#1a1b26";
      #         foreground = "#a9b1d6";
      #       };
      #       hints = {
      #         start = {
      #           foreground = "#1a1b26";
      #           background = "#7aa2f7";
      #         };
      #         end = {
      #           foreground = "#7aa2f7";
      #           background = "#1a1b26";
      #         };
      #       };
      #       line_indicator = {
      #         foreground = "None";
      #         background = "None";
      #       };
      #       normal = {
      #         black = "#32344a";
      #         red = "#f7768e";
      #         green = "#9ece6a";
      #         yellow = "#e0af68";
      #         blue = "#7aa2f7";
      #         magenta = "#ad8ee6";
      #         cyan = "#449dab";
      #         white = "#787c99";
      #       };
      #       bright = {
      #         black = "#444b6a";
      #         red = "#ff7a93";
      #         green = "#b9f27c";
      #         yellow = "#ff9e64";
      #         blue = "#7da6ff";
      #         magenta = "#bb9af7";
      #         cyan = "#0db9d7";
      #         white = "#acb0d0";
      #       };
      #       dim = {
      #         black = "#32344a";
      #         red = "#f7768e";
      #         green = "#9ece6a";
      #         yellow = "#e0af68";
      #         blue = "#7aa2f7";
      #         magenta = "#ad8ee6";
      #         cyan = "#449dab";
      #         white = "#787c99";
      #       };
      #     };
      #   };
      # };

    };

  };
}
