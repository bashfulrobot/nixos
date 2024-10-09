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
            modules-left = [ "custom/nix" "wlr/workspaces" "mpris" ];
            modules-center = [ "wlr/taskbar" ];
            modules-right = [
              "pulseaudio"
              "network#interface"
              "network#speed"
              "cpu"
              "temperature"
              "clock"
              "tray"
            ];

            persistent_workspaces = {
              "1" = [ ];
              "2" = [ ];
              "3" = [ ];
            };

            "wlr/workspaces" = {
              format = "{icon}";
              on-click = "activate";
              sort-by-number = true;
              format-icons = {
                "1" = '''';
                "2" = ''󰈹'';
                "3" = ''󰒱'';
                "4" = ''󰧑'';
              };
            };

            mpris = {
              format =
                "{status_icon}<span weight='bold'>{artist}</span> | {title}";
              status-icons = {
                playing = "󰎈";
                paused = "󰏤";
                stopped = "󰓛";
              };
            };

            "custom/nix" = { format = "󱄅 "; };

            "wlr/taskbar" = { on-click = "activate"; };

            pulseaudio = {
              format = "󰓃 {volume}%";
            };

            "network#interface" = {
              format-ethernet = "󰣶 {ifname}";
              format-wifi = "󰖩 {ifname}";
              tooltip = true;
              tooltip-format = "{ipaddr}";
            };

            "network#speed" = {
              format =
                "⇡ {bandwidthUpBits} ⇣ {bandwidthDownBits}";
            };

            cpu = {
              format =
                " {usage}% 󱐌 {avg_frequency}";
            };

            temperature = {
              format =
                "{icon} {temperatureC} °C";
              format-icons = [ "" "" "" "󰈸" ];
            };

            clock = {
              format = "  {:%H:%M}";
              format-alt = "󰃭 {:%Y-%m-%d}";
            };

            tray = {
              icon-size = 16;
              spacing = 8;
            };
          };
        };

        style = ''
          * {
            min-height: 0;
          }

          window#waybar {
            font-family: 'Inter', 'RobotoMono Nerd Font';
            font-size: 14px;
          }

          #custom-nix {
            padding: 2px 8px;
          }

          #workspaces button {
            padding: 2px 8px;
            margin: 0 8px 0 0;
          }

          #workspaces button.active {
          }

          #taskbar button.active {
          }

          .modules-right * {
            padding: 0 8px;
            margin: 0 0 0 4px;
          }

          #mpris {
            padding: 0 8px;
            color: #8A889D;
          }

          #tray {
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
