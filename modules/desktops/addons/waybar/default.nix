# { lib, config, inputs, pkgs, ... }:
{ pkgs, config, lib, inputs, ... }:
let
  cfg = config.desktops.addons.waybar;
  # Used in my home manager code at the bottom of the file.
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {
  options = {
    desktops.addons.waybar.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable waybar barr";
    };
  };

  config = lib.mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [
    #   waybar
    # ];
    home-manager.users."${username}" = {
      programs.waybar = {
        enable = true;
        package = pkgs.waybar;
        systemd.enable = true;
        settings = {
          mainBar = {
            layer = "top";
            position = "top";
            mod = "dock";
            exclusive = true;
            passthrough = false;
            gtk-layer-shell = true;
            height = 0;
            modules-left = [ "clock" "hyprland/workspaces" ];
            modules-center = [ "custom/uptime" ];
            modules-right =
              [ "pulseaudio" "temperature" "cpu" "memory" "tray" ];
            clock = {
              format = "{:%b %d - %H:%M}";
              tooltip = false;
            };
            "hyprland/workspaces" = { };
            "custom/uptime" = {
              exec = ./scripts/uptime.sh;
              interval = "60";
              tooltip = false;
              format = "{}";
            };
            pulseaudio = {
              format = "<span color='#cba6f7'>{icon}</span>{volume}%";
              tooltip = false;
              format-muted = "<span color='#f38ba8'> </span>Muted";
              format-icons = { default = [ " " " " " " ]; };
              on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
              scroll-step = 5;
            };
            temperature = {
              tooltip = false;
              format = "<span color='#ea76cb'>{icon}</span> {temperatureC}°C";
              format-icons = [ "" "" "" "" "" "" ];
            };
            cpu = {
              format = "<span color='#eba0ac'>{icon}</span>{usage}%";
              format-icons = [ " " "󰪞 " "󰪟 " "󰪠 " "󰪡 " "󰪢 " "󰪣 " "󰪤 " "󰪥 " ];
              tooltip = false;
            };
            memory = {
              format = "<span color='#fab387'>{icon}</span>{used}/{total}";
              format-icons = [ " " "󰪞 " "󰪟 " "󰪠 " "󰪡 " "󰪢 " "󰪣 " "󰪤 " "󰪥 " ];
              tooltip = false;
            };
          };
        };
        style = ''
          * {
            border: none;
            border-radius: 0;
            font-family: "JetBrainsMono NF";
            font-size: 12.5px;
            font-weight: bold;
          }

          window#waybar {
            background-color: transparent;
            color: #cdd6f4;
          }

          #workspaces button {
            padding: 0 4px;
            color: #cdd6f4;
          }

          #workspaces button.active {
            color: #89dceb;
          }

          #workspaces button.urgent {
            color: #f38ba8;
          }

          #workspaces button.persistent {
            color: #f9e2af;
          }

          #workspaces button:hover {
            background: #1e1e2e;
          }

          #custom-uptime,
          #pulseaudio,
          #clock,
          #workspaces,
          #disk,
          #memory,
          #tray,
          #mode,
          #temperature,
          #cpu {
            background: #1e1e2e;
            color: #cdd6f4;
            margin: 2px 3px;
            padding: 0 10px;
            border-radius: 5px;
          }
        '';

        # TODO: example else if - https://github.com/MatthiasBenaets/nixos-config/blob/2d9d8c7f847e586d2e2ec14ed669416e4a758ea4/rsc/archive/dwm/waybar.nix#L49
        # home.file = {
        #   ".config/waybar/config" = {

        #   };
        # };
      };
    };
  };
}
