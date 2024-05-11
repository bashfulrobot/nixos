{ pkgs, ... }: {
  programs.alacritty = {
    settings = {
      colors = {
        primary = {
          background = "#282828";
          foreground = "#ebdbb2";
        };
        cursor = {
          text = "#282828";
          cursor = "#ebdbb2";
        };
        vi_mode_cursor = {
          text = "#282828";
          cursor = "#ebdbb2";
        };
        selection = {
          text = "#ebdbb2";
          background = "#3c3836";
        };
        search = {
          matches = {
            foreground = "#3c3836";
            background = "#b8bb26";
          };
          focused_match = {
            foreground = "#3c3836";
            background = "#fe8019";
          };
        };
        footer_bar = {
          background = "#282828";
          foreground = "#ebdbb2";
        };
        hints = {
          start = {
            foreground = "#282828";
            background = "#b8bb26";
          };
          end = {
            foreground = "#b8bb26";
            background = "#282828";
          };
        };
        line_indicator = {
          foreground = "None";
          background = "None";
        };
        normal = {
          black = "#282828";
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
          red = "#cc241d";
          green = "#98971a";
          yellow = "#d79921";
          blue = "#458588";
          magenta = "#b16286";
          cyan = "#689d6a";
          white = "#a89984";
        };
      };
    };
  };
}