{ user-settings, pkgs, config, lib, inputs, system, ... }:
with lib;
let
  cfg = config.desktops.hyprland.add-ons.waybar-dev;
  theme = user-settings.theme.CatppuccinMacchiato;
  # waybar-clock-hover =
  # pkgs.callPackage ./build/scripts/waybar-clock-hover.nix { };
in {
  options.desktops.hyprland.add-ons.waybar-dev.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable waybar for hyprland";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [
        #waybar-clock-hover
      ];

    home-manager.users.${user-settings.user.username} = {
      programs.waybar = {
        enable = true;
        systemd.enable = true;
        settings = {
          mainBar = {
            layer = "top";
            position = "top";
            margin = "10 20 -5 20";

            ##### Modules Alignment
            modules-left = [ "hyprland/workspaces" "hyprland/submap" ];
            modules-center = [ "hyprland/window" ];
            modules-right = [ "mpd" "clock" "battery" "custom/power" "group/overflow" ];
            # modules-right = [
            #   "mpd"
            #   "clock"
            #   "backlight/slider"
            #   "battery"
            #   "network"
            #   "tray"
            #   "custom/power"
            # ];

            ##### Define Groups
            "group/overflow" = {
              orientation = "inherit";
              drawer = {
                transition-duration = 500;
                children-class = "not-power";
                transition-left-to-right = true;
              };
              modules = [ "custom/overflow" "backlight/slider" "network" "tray" ];
            };

            ###### Define Modules

            "custom/overflow" = {
              format = "";
            };

            "network#down" = {
              format = "󰁅 {bandwidthDownBits}";
              tooltip-format = "{ifname} {ipaddr}";
              interval = 1;
            };

            "network#up" = {
              format = "󰁝 {bandwidthUpBits}";
              tooltip-format = "{ifname} {ipaddr}";
              interval = 1;
            };

            network = {
              #interface = "wlp2*"; # (Optional) To force the use of this interface
              format-wifi = "{essid} ({signalStrength}%) ";
              format-ethernet = "{ifname}: {ipaddr}/{cidr} ";
              format-linked = "{ifname} (No IP) ";
              format-disconnected = "Disconnected ";
              format-alt = "{ifname}: {ipaddr}/{cidr}";
              on-click-right = "nmtui";
            };

            pulseaudio = {
              #"scroll-step = 1; // %, can be a float
              format = "{volume}%{format_source}";
              format-bluetooth = "{volume}%{format_source}";
              format-bluetooth-muted = " {format_source}";
              format-muted = " {format_source}";
              format-source = "{volume}% ";
              format-source-muted = "";
              on-click-right = "pavucontrol";
            };

            bluetooth = {
              format = " {status}";
              format-connected = " {device_alias}";
              format-connected-battery =
                " {device_alias} {device_battery_percentage}%";
              # "format-device-preference = [ "device1", "device2" ]; // preference list deciding the displayed device
              tooltip-format = ''
                {controller_alias}	{controller_address}

                {num_connections} connected'';
              tooltip-format-connected = ''
                {controller_alias}	{controller_address}

                {num_connections} connected

                {device_enumerate}'';
              tooltip-format-enumerate-connected =
                "{device_alias}	{device_address}";
              tooltip-format-enumerate-connected-battery =
                "{device_alias}	{device_address}	{device_battery_percentage}%";
            };
            clock = {
              format = "{:%H:%M }";
              format-alt = "{:%Y-%m-%d}";
              interval = 1;
              timezone = "America/Vancouver";
            };

            "tray" = {
              # "icon-size" = 21;
              spacing = 5;
            };

            "custom/power" = {
              format = "󰤆 ";
              tooltip = true;
              on-click = "${pkgs.nwg-bar}/bin/nwg-bar";
            };

            "hyprland/window" = {
              "max-length" = 200;
              "separate-outputs" = true;
            };

            "hyprland/workspaces" = {
              all-outputs = true;
              format = "{name}: {icon}";
              format-icons = {
                "1" = "";
                "2" = "";
                "3" = "";
                "4" = "";
                "5" = "";
                "6" = "";
                "7" = "";
                "8" = "";
                "9" = "";
                "10" = "";
                "urgent" = "";
                "focused" = "";
                #"default" = "";
              };
              on-click = "activate";
              on-scroll-up =
                "${pkgs.hyprland}/bin/hyprctl dispatch workspace e+1";
              on-scroll-down =
                "${pkgs.hyprland}/bin/hyprctl dispatch workspace e-1";
            };

            "hyprland/submap" = {
              format = "󰔡 {}";
              max-length = 100;
            };

            mpd = {
              format =
                "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ ";
              format-disconnected = "Disconnected ";
              format-stopped =
                "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
              unknown-tag = "N/A";
              interval = 2;
              consume-icons = { on = " "; };
              random-icons = {
                off = ''<span color="${theme.error}"></span> '';
                on = " ";
              };
              repeat-icons = { on = " "; };
              state-icons = {
                paused = "";
                playing = "";
              };
              tooltip-format = "MPD (connected)";
              tooltip-format-disconnected = "MPD (disconnected)";
            };
            backlight = {
              # device = "acpi_video1";
              format = "{percent}% ";
              format-icons = [ "" "" ];
            };

            battery = {
              states = {
                good = 95;
                warning = 30;
                critical = 15;
              };
              format = "{capacity}% ";
              format-charging = "{capacity}%";
              format-plugged = "{capacity}%";
              format-alt = "{time} ";
              # format-good = ""; # An empty format will hide the module
              # #format-full = "";
              format-icons = [ "" "" "" "" "" ];
            };
            "backlight/slider" = {
              min = 0;
              max = 100;
              orientation = "horizontal";
              device = "intel_backlight";
            };
          };
        };

        style = ''
          * {
          border: none;
          border-radius: 0;

          /* font-family: "UbuntuMono Nerd Font";*/
          /*font-family: "Liga SFMono Nerd Font";*/

          font-family: "Work Sans", "Roboto Mono Medium", "Font Awesome 6 Free", "Font Awesome 6 Brands", Helvetica, Arial, sans-serif;

          font-size: 16px;
          font-weight: normal;
          padding: 1px;
          }

          button {
          min-height: 24px;
          min-width: 16px;
          }

          #battery {
          background-color: #000000;
          color: white;
          }

          #battery.charging {
          color: #ffffff;
          background-color: #000000;
          }

          /*
          @keyframes blink {
          to {
          background-color: #ffffff;
          color: #000000;
          }
          } */

          #battery.critical:not(.charging) {
          background-color: ${theme.error};
          color: #ffffff;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
          }

          window#waybar {
          background-color: ${theme.background};
           /* background-color: transparent;*/
          color: ${theme.foreground};
          transition-property: background-color;
          transition-duration: .5s;
          border: 0px solid ${theme.foreground};
          border-radius: 10px;
          }

          window#waybar.hidden {
          opacity: 0.2;
          }

          window#waybar.empty {
          background-color: transparent;
          }
          /*
          window#waybar.solo {
          background-color: #FFFFFF;
          } */

          #workspaces button {
          color: ${theme.foreground};
          padding: 0 3px;
          border-radius: 5px;
          }

          #workspaces button.focused {
          color: ${theme.active};
          }

          #workspaces button.active {
          color: ${theme.active};
          }

          #workspaces button.urgent {
          color: ${theme.error};
          }

          #mode {
          color: ${theme.error};
          padding-left: 2px;
          }

          #submap {
          color: ${theme.error};
          padding-left: 2px;
          }

          #clock {
          color: ${theme.cursor};
          }

          #custom-clock {
          color: ${theme.cursor};
          }

          #network.down {
          color: ${theme.highlight};
          padding-right: 8px;
          }

          #network.up {
          color: ${theme.active};
          padding-right: 8px;
          }

          #pulseaudio,
          #bluetooth,
          #network,
          #mpd,
          #battery,
          #backlight-slider,
          #backlight {
          color: ${theme.active};
          padding-right: 8px;
          }

          #backlight-slider slider {
          min-height: 0px;
          min-width: 0px;
          opacity: 0;
          background-image: none;
          border: none;
          box-shadow: none;
          }
          #backlight-slider trough {
          min-height: 80px;
          min-width: 10px;
          border-radius: 5px;
          background-color: black;
          }
          #backlight-slider highlight {
          min-width: 10px;
          border-radius: 5px;
          background-color: red;
          }

          #tray {
          color: ${theme.foreground};
          padding-right: 8px;
          }

          #custom-power {
          color: ${theme.error};
          padding-right: 8px;
          }
        '';
      };
    };
  };
}
