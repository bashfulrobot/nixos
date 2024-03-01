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

      # Colours specified in the theme folder

      window = {
        # decorations = "full";
        decorations = "none";
        # startup_mode = "Windowed";
        opacity = 0.96;
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
