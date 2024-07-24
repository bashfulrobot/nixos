{ user-settings, pkgs, config, lib, inputs, system, ... }:
with lib;
let
  cfg = config.desktops.hyprland.add-ons.waybar;
  # waybar-clock-hover =
    # pkgs.callPackage ./build/scripts/waybar-clock-hover.nix { };
in {
  options.desktops.hyprland.add-ons.waybar.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable waybar for hyprland";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
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
            modules-center = [ "clock" ];
            modules-right =
              [ "network#down" "network#up" "tray" "custom/power" ];
            modules-left = [ "hyprland/workspaces" "hyprland/submap" ];

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

            clock = {
              format = "{:%Y-%m-%d %H:%M}";
              interval = 1;
              timezone = "America/Vancouver";
              tooltip = false;
            };

          #   "custom/clock" = {
          #     format = " {}";
          #     exec = pkgs.writeShellScript "waybar-clock" ''
          #       #!/run/current-system/sw/bin/env bash
          #       my-date=$(date '+%Y-%m-%d')
          #       my-time=$(date '+%H:%M')
          #       echo "$my-date $my-time"
          # '';
          #     interval = 1;
          #     # tooltip = "exec /etc/profiles/per-user/dustin/bin/waybar-clock-hover tooltip";
          #     timezone = "America/Vancouver";
          #   };

            "custom/power" = {
              format = "󰤆 ";
              tooltip = true;
              on-click = "${pkgs.nwg-bar}/bin/nwg-bar";
            };

            "hyprland/workspaces" = {
              format = "{name}";
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
          };
        };

        style = ''
          * {
            border: none;
            border-radius: 0;
            /* font-family: "UbuntuMono Nerd Font";*/
            font-family: "Liga SFMono Nerd Font";
            font-size: 16px;
            font-weight: normal;
            padding: 1px;
          }

          button {
            min-height: 24px;
            min-width: 16px;
          }

          window#waybar {
            background-color: transparent;
            color: #C0CAF5;
            transition-property: background-color;
            transition-duration: .5s;
            border: 0px solid #C0CAF5;
            border-radius: 10px;
          }

          window#waybar.hidden {
            opacity: 0.2;
          }

          #workspaces button {
            color: #C0CAF5;
            padding: 0 3px;
            border-radius: 5px;
          }

          #workspaces button.focused {
            color: #7AA2F7;
          }

          #workspaces button.active {
            color: #7AA2F7;
          }

          #workspaces button.urgent {
            color: #F7768E;
          }

          #mode {
            color: #F7768E;
            padding-left: 2px;
          }

          #submap {
            color: #F7768E;
            padding-left: 2px;
          }

          #clock {
            color: #BB9AF7;
          }

          #custom-clock {
            color: #BB9AF7;
          }

          #network.down {
            color: #9ECE6A;
            padding-right: 8px;
          }

          #network.up {
            color: #7AA2F7;
            padding-right: 8px;
          }

          #tray {
            color: #C0CAF5;
            padding-right: 8px;
          }

          #custom-power {
            color: #F7768E;
            padding-right: 8px;
          }
        '';
      };
    };
  };
}
