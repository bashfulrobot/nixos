{ pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {

      # Enable true color support
      env.TERM = "alacritty";
      # dynamic_title = true;

      scrolling = {
        history = 10000;
        multiplier = 3;
      };

      bell = {
        animation = "EaseOutQuart";
        duration = 100;
        color = "0x1d2021";
      };

      cursor = {
        style = "Block";
        unfocused_hollow = true;
        # blinking = "Always";
      };

      colors = {
        primary = {
          background = "#22212C";
          foreground = "#F8F8F2";
          dim_foreground = "#FFFFFF";
        };
        cursor = {
          text = "CellBackground";
          cursor = "CellForeground";
        };
        vi_mode_cursor = {
          text = "CellBackground";
          cursor = "CellForeground";
        };
        selection = {
          text = "CellForeground";
          background = "#454158";
        };
        search = {
          matches = {
            foreground = "#454158";
            background = "#8AFF80";
          };
          focused_match = {
            foreground = "#454158";
            background = "#FFCA80";
          };

        };
        footer_bar = {
          background = "#22212C";
          foreground = "#F8F8F2";
        };
        hints = {
          start = {
            foreground = "#22212C";
            background = "#FFFF80";
          };
          end = {
            foreground = "#FFFF80";
            background = "#22212C";
          };
        };
        line_indicator = {
          foreground = "None";
          background = "None";
        };
        normal = {
          black = "#7970A9";
          red = "#FF9580";
          green = "#8AFF80";
          yellow = "#FFFF80";
          blue = "#9580FF";
          magenta = "#FF80BF";
          cyan = "#80FFEA";
          white = "#F8F8F2";
        };
        bright = {
          black = "#7970A9";
          red = "#FFAA99";
          green = "#A2FF99";
          yellow = "#FFFF99";
          blue = "#AA99FF";
          magenta = "#FF99CC";
          cyan = "#99FFEE";
          white = "#FFFFFF";
        };
        dim = {
          black = "#7970A9";
          red = "#FF9580";
          green = "#8AFF80";
          yellow = "#FFFF80";
          blue = "#9580FF";
          magenta = "#FF80BF";
          cyan = "#80FFEA";
          white = "#F8F8F2";
        };
      };
      window = {
        decorations = "full";
        # decorations = "none";
        # startup_mode = "Windowed";
        dynamic_padding = true;
        padding = {
          x = 30;
          y = 30;
        };
      };

      font = {
        # Old font - ""Liga SFMono Nerd Font"
        # Old font - "Victor Mono"
        normal = {
          family = "MesloLGS NF";
          style = "Regular";
        };
        bold = {
          family = "MesloLGS NF";
          style = "Bold";
        };
        italic = {
          family = "MesloLGS NF";
          style = "Italic";
        };
        bold_italic = {
          family = "MesloLGS NF";
          style = "Bold Italic";
        };
        size = 18;
        offset = {
          x = 1;
          y = 1;
        };
      };

      keyboard = {
        bindings = [
          {
            key = "V";
            mods = "Control|Shift";
            action = "Paste";
          }
          {
            key = "C";
            mods = "Control|Shift";
            action = "Copy";
          }
          {
            key = "Up";
            mods = "Control|Shift";
            action = "ScrollPageUp";
          }
          {
            key = "Down";
            mods = "Control|Shift";
            action = "ScrollPageDown";
          }
        ];
      };
    };
  };
}
