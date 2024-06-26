{ user-settings, config, pkgs, lib, ... }:
let
  cfg = config.cli.alacritty;

in {

  options = {
    cli.alacritty.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the Alacritty terminal.";
    };
  };

  config = lib.mkIf cfg.enable {

    ### HOME MANAGER SETTINGS
    home-manager.users."${user-settings.user.username}" = {

      home.packages = with pkgs; [ mimeo ];

      programs.alacritty = {
        enable = true;
        settings = {

          # Enable true color support
          env.TERM = "alacritty";
          # env.TERM = "xterm-256color";

          # shell.program = "tmux";

          selection.save_to_clipboard = true;

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
            decorations = "full";
            # decorations = "none";
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
            # Old font - "MesloLGS NF"
            normal = {
              family = "Victor Mono";
              style = "Regular";
            };
            bold = {
              family = "Victor Mono";
              style = "Bold";
            };
            italic = {
              family = "Victor Mono";
              style = "Italic";
            };
            bold_italic = {
              family = "Victor Mono";
              style = "Bold Italic";
            };
            size = 18;
            offset = {
              x = 1;
              y = 1;
            };
          };
          hints = {
            enabled = [{
              regex = ''
                (mailto:|gemini:|gopher:|https:|http:|news:|file:|git:|ssh:|ftp:)[^\u0000-\u001F\u007F-\u009F<>"\\s{-}\\^⟨⟩`]+'';
              command = "${pkgs.mimeo}/bin/mimeo";
              post_processing = true;
              mouse.enabled = true;
            }];
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
    };
  };
}
