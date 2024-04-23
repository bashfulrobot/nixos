{ pkgs, ... }: {
  programs.alacritty = {
    settings = {
      colors = {
        primary = {
          background = "#3D3D3D";
          foreground = "#F2F2F2";
        };
        cursor = {
          text = "#3D3D3D";
          cursor = "#F2F2F2";
        };
        vi_mode_cursor = {
          text = "#3D3D3D";
          cursor = "#F2F2F2";
        };
        selection = {
          text = "#F2F2F2";
          background = "#4C2294";
        };
        search = {
          matches = {
            foreground = "#4C2294";
            background = "#F2F2F2";
          };
          focused_match = {
            foreground = "#4C2294";
            background = "#F2F2F2";
          };
        };
        footer_bar = {
          background = "#3D3D3D";
          foreground = "#F2F2F2";
        };
        hints = {
          start = {
            foreground = "#3D3D3D";
            background = "#F2F2F2";
          };
          end = {
            foreground = "#F2F2F2";
            background = "#3D3D3D";
          };
        };
        line_indicator = {
          foreground = "None";
          background = "None";
        };
        normal = {
          black = "#3D3D3D";
          red = "#FF5555";
          green = "#50FA7B";
          yellow = "#F1FA8C";
          blue = "#BD93F9";
          magenta = "#FF79C6";
          cyan = "#8BE9FD";
          white = "#F2F2F2";
        };
        bright = {
          black = "#4C2294";
          red = "#FF6E6E";
          green = "#69FF94";
          yellow = "#FFFFA5";
          blue = "#D6ACFF";
          magenta = "#FF92DF";
          cyan = "#A4FFFF";
          white = "#FFFFFF";
        };
        dim = {
          black = "#3D3D3D";
          red = "#FF5555";
          green = "#50FA7B";
          yellow = "#F1FA8C";
          blue = "#BD93F9";
          magenta = "#FF79C6";
          cyan = "#8BE9FD";
          white = "#F2F2F2";
        };
      };
    };
  };
}