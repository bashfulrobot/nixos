# https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/
{ user-settings, pkgs, config, lib, ... }:
let cfg = config.desktops.hyprland.waybar;

in {
  options = {
    desktops.hyprland.waybar.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Waybar.";
    };
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = with pkgs;
      [

      ];

    home-manager.users."${user-settings.user.username}" = {

      home.packages = [ pkgs.inter ];

      services.playerctld.enable = true;

      programs.waybar = {
        enable = true;
        package = pkgs.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        });
        settings = {
          mainBar = {
            margin = "0";
            layer = "top";
            modules-left =
              [ "custom/nix" "hyprland/window" "hyprland/workspaces" "mpris" ];
            modules-center = [ "wlr/taskbar" ];
            modules-right = [
              "pulseaudio"
              "network#interface"
              # "network#speed"
              "bluetooth"
              # "cpu"
              # "temperature"
              "clock"
              # "tray"
              "group/systray"

            ];

            "hyprland/workspaces" = {
              active-only = false; # Only show active workspaces
              all-outputs = true;
              disable-scroll = true;
              format = "{name}";
              format-icons = {
                active = "";
                default = "";
                sort-by-number = true;
                urgent = "";
              };
              on-click = "activate";
            };

            "hyprland/window" = {
              format = "{class}";
              rewrite = {
                "code-url-handler" = "vscode";
                # "org.qutebrowser.qutebrowser" = "qutebrowser";
                # "org.wezfurlong.wezterm" = "wezterm";
              };
            };

            mpris = {
              format =
                "{status_icon}<span weight='bold'>{artist}</span> | {title}";
              status-icons = {
                playing =
                  "<span foreground='#A1EFD3'></span> "; # Font Awesome icon for playing
                paused =
                  "<span foreground='#FFE6B3'></span> "; # Font Awesome icon for paused
                stopped =
                  "<span foreground='#F48FB1'></span> "; # Font Awesome icon for stopped
              };
            };

            "custom/nix" = { format = " "; }; # Nerd Fonts NixOS icon

            "wlr/taskbar" = { on-click = "activate"; };

            pulseaudio = {
              format =
                "<span foreground='#F48FB1'> </span>  {volume}%"; # Font Awesome icon for volume
              on-click = "pavucontrol"; # Launch pavucontrol when clicked
            };

            "network#interface" = {
              format-ethernet =
                "<span foreground='#91DDFF'> </span> {ifname}"; # Font Awesome icon for ethernet
              format-wifi =
                "<span foreground='#91DDFF'> </span>{ifname}"; # Font Awesome icon for wifi
              tooltip = true;
              tooltip-format = "{ipaddr}";
              on-click =
                "alacritty -e nmtui"; # Launch nmtui in Alacritty terminal
            };

            "network#speed" = {
              format =
                "<span foreground='#78A8FF'>⇡</span>{bandwidthUpBits} <span foreground='#78A8FF'>⇣</span>{bandwidthDownBits}";
            };

            bluetooth = {
              format =
                "<span foreground='#A1EFD3'></span>"; # Font Awesome icon for Bluetooth
              tooltip = true;
              tooltip-format = "{status}"; # Show status on mouse over
              on-click = "blueman-manager"; # Launch Blueman when clicked
            };

            cpu = {
              format =
                "<span foreground='#D4BFFF'>  </span>{usage}% <span foreground='#D4BFFF'>󱐌 </span>{avg_frequency}";
            };

            temperature = {
              format =
                "<span foreground='#FFE6B3'>{icon} </span>{temperatureC} °C";
              format-alt =
                "<span foreground='#FFE6B3'>{icon} </span>{temperatureF} °F";
              format-icons =
                [ "" "" "" "" ]; # Updated to ensure distinct icons
            };

            clock = {
              format = "<span foreground='#A1EFD3'>{:%H:%M}  </span>";
              format-alt = "<span foreground='#A1EFD3'>{:%Y-%m-%d}  </span>";
              tooltip-format = "<tt><small>{calendar}</small></tt>";
              calendar = {
                mode = "year";
                mode-mon-col = 3;
                weeks-pos = "right";
                on-scroll = 1;
                format = {
                  months = "<span color='#ffead3'><b>{}</b></span>";
                  days = "<span color='#ecc6d9'><b>{}</b></span>";
                  weeks = "<span color='#99ffdd'><b>W{}</b></span>";
                  weekdays = "<span color='#ffcc66'><b>{}</b></span>";
                  today = "<span color='#ff6699'><b><u>{}</u></b></span>";
                };
              };
              actions = {
                on-click-right = "mode";
                on-scroll-up = "tz_up";
                on-scroll-down = "tz_down";
                # on-scroll-up = "shift_up";
                # on-scroll-down = "shift_down";
              };
            };

            "group/systray" = {
              "orientation" = "horizontal";
              "modules" = [ "custom/showtray" "tray" ];
              "drawer" = {
                "transition-duration" = 300;
                "children-class" = "minimized";
              };
            };
            tray = {
              icon-size = 16;
              spacing = 8;
            };
            "custom/showtray" = {
              "format" = "";
              "tooltip" = false;
            };

          };
        };

        style = ''
          * {
            min-height: 0;
            color: #CBE3E7;
          }

          window#waybar {
            border-bottom: solid 2px #2D2B40;
            font-family: 'Font Awesome 6 Free', 'Work Sans';
            font-size: 14px;
          }

          tooltip {
            background-color: #2D2B40;
            color: #CBE3E7;
          }

          #custom-nix {
            color: #91DDFF;
            padding: 2px 8px;
          }

          #workspaces button {
            padding: 2px 8px;
            margin: 0 8px 0 0;
          }

          #workspaces button.active {
            background-color: #2D2B40;
          }

          #taskbar button.active {
            background-color: #2D2B40;
          }

          .modules-right * {
            padding: 0 8px;
            margin: 0 0 0 4px;
          }

          #mpris {
            background-color: #2D2B40;
            padding: 0 8px;
            color: #8A889D;
          }

          #tray {
            background-color: #2D2B40;
            padding: 0 8px 0 8px;
          }

          #tray * {
            padding: 0;
            margin: 0;
          }
        '';
      };

    };
  };
}
