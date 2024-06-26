{ config, osConfig, pkgs, lib, ... }:
# https://raw.githubusercontent.com/georgewhewell/nixos-host/master/home/waybar.nix
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = ''
        ${builtins.readFile "${pkgs.waybar}/etc/xdg/waybar/style.css"}

        window#waybar {
        /* Using Gruvbox bg2 for background with 70% transparency */
        background-color:rgba(80, 73, 69, 0.85);
        border-bottom: none;
      }

      #pulseaudio {
        /* Using Gruvbox green1 for background and bg for color */
        background-color: #afbe8c;
        color: #32302f;
      }

      #network {
        /* Using Gruvbox green for background and bg for color */
        background-color: #a9b665;
        color: #32302f;
      }

      #bluetooth {
        /* Using Gruvbox bg for background and green1 for color */
        background-color: #32302f;
        color: #afbe8c;
      }

      #cpu {
        /* Using Gruvbox blue for background and bg for color */
        background-color: #7daea3;
        color: #32302f;
      }

      #memory {
        /* Using Gruvbox orange for background and bg for color */
        background-color: #e78a4e;
        color: #32302f;
      }

      #temperature {
        /* Using Gruvbox green1 for background and bg for color */
        background-color: #afbe8c;
        color: #32302f;
      }

      #battery {
        /* Using Gruvbox green for background and bg for color */
        background-color: #a9b665;
        color: #32302f;
      }

      #clock {
        /* Using Gruvbox bg1 for background and fg for color */
        background-color: #3c3836;
        color: #d4be98;
      }

      #tray {
        /* Using Gruvbox bg for background and fg for color */
        background-color: #32302f;
        color: #d4be98;
      }

      #workspaces {

        border-radius: 0px;
        border: solid 0px #fff;

      }

      #workspaces button.persistent {
          color: #3c3836;
      }

      #workspaces button {
          border-radius: 0px;
          color: #fff;
          text-shadow: 0px 0px 3px #fff;
      }

      #workspaces button.active {
        background-color: #e0abc4;
        color: #32302f;

      }

      #workspaces button:hover {
        background-color: transparent;
        color: #e0abc4;
      }

        * {
          ${
            if osConfig.networking.hostName == "evo" then ''
              font-size: 16px;
            '' else ''
              /*else*/
            ''
          }
        }

        /* Each module */
        #workspaces,
        #pulseaudio,
        #network,
        #bluetooth,
        #cpu,
        #memory,
        #temperature,
        #battery,
        #clock,
        #tray {
          background-color: #000;
          border-radius: 4px;
          margin: 6px 3px;
          padding: 6px 12px;
        }
    '';
    settings = [{
      height = 20;
      layer = "top";
      position = "top";
      tray = { spacing = 20; };
      #modules-center = [ "sway/window" ];
      modules-left = [ "sway/workspaces" "sway/mode" "hyprland/workspaces" ];
      modules-right =
        [ "pulseaudio" "network" "bluetooth" "cpu" "memory" "temperature" ]
        ++ (if osConfig.networking.hostName == "evo" then
          [ "battery" ]
        else
          [ ]) ++ [ "clock" "tray" ];
      battery = {
        format = "{capacity}% {icon}";
        format-alt = "{time} {icon}";
        format-charging = "{capacity}% ";
        format-icons = [ "" "" "" "" "" ];
        format-plugged = "{capacity}% ";
        states = {
          critical = 15;
          warning = 30;
        };
      };
      bluetooth = {
        format = "{icon}";
        format-icons = {
          enabled = "      ";
          disabled = "";
        };
        tooltip-format = "{}";
        on-click = "blueberry";
        on-click-right = "blueman-manager";
      };
      clock = {
        format = "{:%Y-%m-%d    %H:%M}";
        # format-alt = "{:%Y-%m-%d}";
        # tooltip-format = "{:%Y-%m-%d | %H:%M}";
      };
      cpu = {
        format = "{usage}% ";
        tooltip = false;
      };
      memory = { format = "{}% "; };
      network = {
        interval = 1;
        format-alt = "{ifname}: {ipaddr}/{cidr}";
        format-disconnected = "Disconnected ⚠";
        format-ethernet =
          "{ifname}: {ipaddr}/{cidr}   up: {bandwidthUpBits} down: {bandwidthDownBits}";
        format-linked = "{ifname} (No IP) ";
        format-wifi = "{essid} ({signalStrength}%) ";
        on-click-right = "alacritty -e nmtui";
      };
      pulseaudio = {
        format = "{volume}% {icon} {format_source}";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = " {icon} {format_source}";
        format-icons = {
          car = "";
          default = [ "" "" "" ];
          handsfree = "";
          headphones = "";
          headset = "";
          phone = "";
          portable = "";
        };
        format-muted = " {format_source}";
        format-source = "{volume}% ";
        format-source-muted = "";
        on-click = "pavucontrol";
      };
      "sway/mode" = { format = ''<span style="italic">{}</span>''; };
      temperature = {
        critical-threshold = 80;
        format = "{temperatureC}°C {icon}";
        format-icons = [ "" "" "" ];
      };
      "hyprland/workspaces" = {
        disable-scroll = false;
        on-scroll-up = "hyprctl dispatch workspace -1";
        on-scroll-down = "hyprctl dispatch workspace +1";
        # format = "{icon}";
        # format-icons = [ ];
        # "1": "一",
        # "2": "二",
        # "3": "三",
        # "4": "四",
        # "5": "五",
        # "6": "六",
        # "7": "七",
        # "8": "八",
        # "9": "九",
        # "10": "〇",
        # //		"active": "",
        # //		"default": "󰧞"
      };

    }];
  };
}
