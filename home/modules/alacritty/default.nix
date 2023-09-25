{ pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {

      # Enable true color support
      env.TERM = "alacritty";
      dynamic_title = true;

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
        blinking = "Always";
      };

      colors = {
        primary = {
          background = "#1d2021";
          foreground = "#ebdbb2";
          dim_foreground = "#bdae93";
        };
        cursor = {
          text = "#1d2021";
          cursor = "#ebdbb2";
        };
        vi_mode_cursor = {
          text = "#1d2021";
          cursor = "#ebdbb2";
        };
        selection = {
          text = "CellForeground";
          background = "#3c3836";
        };
        search = {
          matches = {
            foreground = "CellBackground";
            background = "#d79921";
          };
          footer_bar = {
            background = "#1d2021";
            foreground = "#ebdbb2";
          };
        };
        normal = {
          black = "#1d2021";
          red = "#cc241d";
          green = "#98971a";
          yellow = "#d79921";
          blue = "#458588";
          magenta = "#b16286";
          cyan = "#689d6a";
          white = "#a89984";
        };
        bright = {
          black = "#928374";
          red = "#fb4934";
          green = "#b8bb26";
          yellow = "#fabd2f";
          blue = "#83a598";
          magenta = "#d3869b";
          cyan = "#8ec07c";
          white = "#ebdbb2";
        };
        dim = {
          black = "#282828";
          red = "#9d0006";
          green = "#79740e";
          yellow = "#b57614";
          blue = "#076678";
          magenta = "#8f3f71";
          cyan = "#427b58";
          white = "#a89984";
        };
      };
      window = {
        # decorations = "full";
        decorations = "none";
        # startup_mode = "Windowed";
        dynamic_padding = true;
        padding = {
          x = 30;
          y = 30;
        };
      };

      font = {
        normal = {
          family = "Liga SFMono Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "Liga SFMono Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "Liga SFMono Nerd Font";
          style = "Italic";
        };
        bold_italic = {
          family = "Liga SFMono Nerd Font";
          style = "Bold Italic";
        };
        size = 18;
        offset = {
          x = 1;
          y = 1;
        };
      };

      key_bindings = [
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
}
