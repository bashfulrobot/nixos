{ config, osConfig, pkgs, lib, ... }:
# https://raw.githubusercontent.com/georgewhewell/nixos-host/master/home/waybar.nix
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = ''
      ${builtins.readFile ./waybar.css}
    '';
    settings = [{
      height = 20;
      layer = "top";
      position = "top";
      margin-top = 10;
      margin-bottom = 5;
      # tray = { spacing = 20; };

      modules-left =
        [ "idle_inhibitor" "pulseaudio" "cpu" "memory" "temperature" ];

      modules-center =
        [ "custom/launcher" "custom/media" "wlr/taskbar" "custom/power" ];

      modules-right = [
        "custom/layout"
        "custom/updater"
        "custom/snip"
        "backlight"
        "keyboard-state"
      ] ++ (if osConfig.networking.hostName == "evo" then [
        "battery"
        "battery#bat2"
      ] else
        [ ]) ++ [ "network" "tray" "clock" ];

      "keyboard-state" = {
        numlock = true;
        capslock = true;
        format = " {name} {icon}";
        format-icons = {
          locked = "";
          unlocked = "";
        };
      };

      "wlr/taskbar" = {
        format = "{icon}";
        "icon-size" = 20;
        "icon-theme" = "Star";
        "tooltip-format" = "{title}";
        "on-click" = "minimize";
        "on-click-middle" = "close";
        "on-click-right" = "activate";
      };

      "sway/language" = { format = " {}"; };

      "idle_inhibitor" = {
        format = "{icon}";
        format-icons = {
          activated = "";
          deactivated = "";
        };
      };

      tray = {
        "icon-size" = 20;
        spacing = 10;
      };

      clock = {
        # "timezone" = "America/New_York";
        "tooltip-format" = ''
          <big>{:%Y %B}</big>
          <tt><small>{calendar}</small></tt>'';
        "format-alt" = "{:%Y-%m-%d}";
      };

      cpu = {
        format = "{usage}% ";
        tooltip = false;
      };

      memory = { format = "{}% "; };

      temperature = {
        # "thermal-zone" = 2;
        # "hwmon-path" = "/sys/class/hwmon/hwmon2/temp1_input";
        "critical-threshold" = 80;
        # "format-critical" = "{temperatureC}°C {icon}";
        format = "{temperatureC}°C {icon}";
        "format-icons" = [ "" "" "" ];
      };

      backlight = {
        format = "{percent}% {icon}";
        "format-icons" = [ "" "" ];
      };

      battery = {
        states = {
          # "good" = 95;
          warning = 30;
          critical = 15;
        };
        format = "{capacity}% {icon}";
        "format-charging" = "{capacity}% ";
        "format-plugged" = "{capacity}% ";
        "format-alt" = "{time} {icon}";
        "format-icons" = [ "" "" "" "" "" ];
      };

      "battery#bat2" = { bat = "BAT2"; };

      network = {
        # "interface" = "wlp2*";
        "format-wifi" = "{essid} ({signalStrength}%) ";
        "format-ethernet" = "Connected ";
        "tooltip-format" = "{ifname} via {gwaddr} ";
        "format-linked" = "{ifname} (No IP) ";
        "format-disconnected" = "Disconnected ⚠";
        "format-alt" = "{ifname}: {ipaddr}/{cidr}";
        "on-click-right" = "bash ~/.config/rofi/wifi_menu/rofi_wifi_menu";
      };

      pulseaudio = {
        format = "{volume}% {icon}";
        "format-bluetooth" = "{volume}% {icon}";
        "format-bluetooth-muted" = "{icon} {format_source}";
        "format-muted" = "{format_source}";
        "format-source" = "";
        "format-source-muted" = "";
        "format-icons" = {
          headphone = "";
          "hands-free" = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = [ "" "" "" ];
        };
        "on-click" = "pavucontrol";
      };

      "custom/media" = {
        format = "{icon} {}";
        "return-type" = "json";
        "max-length" = 15;
        "format-icons" = {
          spotify = " ";
          default = " ";
        };
        escape = true;
        "exec" = "$HOME/.config/system_scripts/mediaplayer.py 2> /dev/null";
        "on-click" = "playerctl play-pause";
      };

      "custom/launcher" = {
        format = " ";
        "on-click" =
          "rofi -show drun -theme ~/.config/rofi/wayfire/config.rasi";
        "on-click-right" = "killall rofi";
      };

      "custom/power" = {
        format = "  ";
        "on-click" = "nwg-bar";
        "on-click-right" = "killall nwg-bar";
      };

      "custom/layout" = {
        format = "";
        "on-click" = "bash ~/.config/system_scripts/layout.sh";
      };

      "custom/updater" = {
        format = "  {} Updates";
        "exec" = "checkupdates | wc -l";
        "exec-if" = "[[ $(checkupdates | wc -l) != 0 ]]";
        interval = 15;
        "on-click" = "alacritty -e yay -Syu";
      };

      "hyprland/workspaces" = {
        disable-scroll = false;
        on-scroll-up = "hyprctl dispatch workspace -1";
        on-scroll-down = "hyprctl dispatch workspace +1";
        # format = "{icon}";
        # format-icons = [ ];
        # "1": "一"
        # "2": "二"
        # "3": "三"
        # "4": "四"
        # "5": "五"
        # "6": "六"
        # "7": "七"
        # "8": "八"
        # "9": "九"
        # "10": "〇"
        # //		"active": ""
        # //		"default": "󰧞"
      };

    }];
  };
}
