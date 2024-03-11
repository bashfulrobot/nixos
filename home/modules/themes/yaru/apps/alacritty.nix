{ pkgs, ... }: {
  programs.alacritty = {
    settings = {
      colors = {
        primary = {
          background = "#2E3436";
          foreground = "#D3D7CF";
        };
        cursor = {
          text = "#2E3436";
          cursor = "#D3D7CF";
        };
        vi_mode_cursor = {
          text = "#2E3436";
          cursor = "#D3D7CF";
        };
        selection = {
          text = "#D3D7CF";
          background = "#555753";
        };
        search = {
          matches = {
            foreground = "#555753";
            background = "#729FCF";
          };
          focused_match = {
            foreground = "#555753";
            background = "#3465A4";
          };
        };
        footer_bar = {
          background = "#2E3436";
          foreground = "#D3D7CF";
        };
        hints = {
          start = {
            foreground = "#2E3436";
            background = "#729FCF";
          };
          end = {
            foreground = "#729FCF";
            background = "#2E3436";
          };
        };
        line_indicator = {
          foreground = "None";
          background = "None";
        };
        normal = {
          black = "#2E3436";
          red = "#CC0000";
          green = "#4E9A06";
          yellow = "#C4A000";
          blue = "#3465A4";
          magenta = "#75507B";
          cyan = "#06989A";
          white = "#D3D7CF";
        };
        bright = {
          black = "#555753";
          red = "#EF2929";
          green = "#8AE234";
          yellow = "#FCE94F";
          blue = "#729FCF";
          magenta = "#AD7FA8";
          cyan = "#34E2E2";
          white = "#EEEEEC";
        };
        dim = {
          black = "#2E3436";
          red = "#CC0000";
          green = "#4E9A06";
          yellow = "#C4A000";
          blue = "#3465A4";
          magenta = "#75507B";
          cyan = "#06989A";
          white = "#D3D7CF";
        };
      };
    };
  };
}