{ config, osConfig, pkgs, lib, ... }:
# https://raw.githubusercontent.com/georgewhewell/nixos-host/master/home/waybar.nix
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = ''
      ${builtins.readFile "${pkgs.waybar}/etc/xdg/waybar/style.css"}
      ${builtins.readFile ./waybar.css}
    '';
    settings = [{
      height = 20;
      layer = "top";
      position = "bottom";
      margin-top = 0;
      margin-bottom = 0;
      tray = { spacing = 20; };
      modules-center = [ "mpris" ];
      modules-left = [ "sway/workspaces" "sway/mode" "hyprland/workspaces" ];
      modules-right = [
        # "wlr/taskbar"
        "pulseaudio"
        "bluetooth"
        "network"
      ]
      # [ "pulseaudio" "network" "bluetooth" "cpu" "memory" "temperature" ]
        ++ (if osConfig.networking.hostName == "dustin-krysak" then
          [ "battery" ]
        else
          [ ]) ++ [ "tray" "clock" ];
      # [ "clock" "tray" ];
      "mpris" = {
        "format" = " {player_icon} {dynamic}";
        "format-paused" = "{status_icon} <i>{dynamic}</i>";
        "player-icons" = {
          "default" = "▶";
          "mpv" = "🎵";
        };
        "status-icons" = { "paused" = "⏸"; };
        "max-length" = 20;
      };
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

      # "group/group-power" = {
      #   orientation = "inherit";
      #   # drawer = {
      #   #   "transition-duration" = 500;
      #   #   "children-class" = "not-power";
      #   #   "transition-left-to-right" = false;
      #   # };
      #   modules = [
      #     "custom/power" // First element is the "group leader" and won't ever be hidden
      #     "custom/quit"
      #     "custom/lock"
      #     "custom/reboot"
      #   ];
      # };
      # "custom/quit" = {
      #   format = "󰗼";
      #   tooltip = false;
      #   "on-click" = "hyprctl dispatch exit";
      # };
      # "custom/lock" = {
      #   format = "󰍁";
      #   tooltip = false;
      #   "on-click" = "swaylock";
      # };
      # "custom/reboot" = {
      #   format = "󰜉";
      #   tooltip = false;
      #   "on-click" = "reboot";
      # };
      # "custom/power" = {
      #   format = "";
      #   tooltip = false;
      #   "on-click" = "shutdown now";
      # };

    }];
  };
}
