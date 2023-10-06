{ config, osConfig, pkgs, lib, ... }:
# https://raw.githubusercontent.com/georgewhewell/nixos-host/master/home/waybar.nix
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = ''
      ${builtins.readFile "${pkgs.waybar}/etc/xdg/waybar/style.css"}

      window#waybar {
        background: transparent;
        border-bottom: none;
        /*border-top: none;*/
      }

      #pulseaudio {
        background-color: #89916C;
        color: #231F26;
      }

      #network {
        background-color: #4E5A44;
        color: #231F26;
      }

      #bluetooth {
        background-color: #231F26;
        color: #89916C;
      }

      #cpu {
        background-color: #4478A9;
        color: #231F26;
      }

      #memory {
        background-color: #A85E41;
        color: #231F26;
      }

      #temperature {
        background-color: #89916C;
        color: #231F26;
      }

      #battery {
        background-color: #4E5A44;
        color: #231F26;
      }

      #clock {
        background-color: #3C3836;
        color: #ebdbb2;
      }

      #tray {
        background-color: #282828;
        color: #ebdbb2;
      }

      * {
        ${
          if osConfig.networking.hostName == "dustin-krysak" then ''
            font-size: 16px;
          '' else ''
            /*else*/
          ''
        }
      }

      /* Each module */
      #pulseaudio,
      #network,
      #bluetooth,
      #cpu,
      #memory,
      #temperature,
      #battery,
      #clock,
      #tray {
        ${
          if osConfig.networking.hostName == "dustin-krysak" then ''
            /* padding: top right bottom left; */
            padding: 0.4em 1.2em 0.4em 1.2em;
          '' else ''
            padding: 0.6em 2.0em 0.6em 2.0em;
          ''
        }

      }
    '';
    settings = [{
      height = 38;
      layer = "top";
      position = "top";
      tray = { spacing = 20; };
      #modules-center = [ "sway/window" ];
      modules-left = [ "sway/workspaces" "sway/mode" ];
      modules-right =
        [ "pulseaudio" "network" "bluetooth" "cpu" "memory" "temperature" ]
        ++ (if osConfig.networking.hostName == "dustin-krysak" then
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
    }];
  };
}
