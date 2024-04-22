{ pkgs, ... }:
let
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {
  home-manager.users."${username}" = {
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
}
