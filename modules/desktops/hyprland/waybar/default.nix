# https://fontawesome.com/v6/icons?q=c&o=r&m=free
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
            modules-left = [
              # "custom/nix"
              "hyprland/workspaces"
              # "hyprland/window"
              "mpris"
            ];
            modules-center = [
              # "wlr/taskbar"
              "clock"
              ];
            modules-right = [
              # "custom/battery"
              # "pulseaudio"
              # "network#interface"
              # "network#speed"
              # "bluetooth"
              # "cpu"
              # "temperature"
              # "clock"
              # "tray"
              "hyprland/window"
              "group/systray"
            ];

            "group/systray" = {
              "orientation" = "horizontal";
              "modules" = [ "custom/showtray" "custom/battery" "pulseaudio" "bluetooth" "network#interface" "tray" ];
              "drawer" = {
                "transition-duration" = 300;
                "children-class" = "minimized";
              };
            };

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
                "code-url-handler" = "VSCode";
                "google-chrome" = "Chrome";
                "chrome-calendar.google.com__calendar_u_1-Profile_4" =
                  "Sysdig Calendar";
                "chrome-sysdig.vitally.io__hubs_553ec776-875e-4a0e-a096-a3da3a0b6ea1_8acc40cb-e3ea-4da8-9570-4be27a10fff6-Default" =
                  "Vitally";
                "chrome-www.icloud.com__notes_-Profile_4" = "Apple Notes";
                "chrome-sysdig.atlassian.net__wiki_spaces_~62200ee98a4bb60068f21eea_overview-Profile_4" =
                  "Confluence";
                "chrome-calendar.google.com__calendar_u_1-Default" =
                  "BR Calendar";
                "chrome-gemini.google.com__-Profile_4" = "Gemini";
                "chrome-github.com__bashfulrobot_nixos-Profile_4" = "Github";
                "chrome-github.com__search-Default" = "Github Code Search";
                "chrome-mail.google.com__mail_u_0_-Default" = "BR Mail";
                "chrome-mail.google.com__mail_u_1_-Profile_4" = "Sysdig Mail";
                "chrome-home-manager-options.extranix.com__-Profile_4" =
                  "HM Search";
                "chrome-app.intercom.com__a_inbox_tdx7wtfd_inbox_team_3988200-Profile_4" =
                  "Intercom";
                "chrome-sysdig.atlassian.net__jira_software_c_projects_FR_issues-Profile_4" =
                  "Jira";
                "chrome-discourse.nixos.org__-Profile_4" = "NixOS Discourse";
                "chrome-wiki.nixos.org__wiki_NixOS_Wiki-Profile_4" =
                  "NixOS Wiki";
                "chrome-search.nixos.org__packages-Profile_4" =
                  "Nixpkgs Search";
                "chrome-notebooklm.google.com__-Profile_4" = "NotebookLM";
                "chrome-chat.developer.gov.bc.ca__channel_devops-sysdig-Profile_4" =
                  "RocketChat";
                "chrome-sysdig.lightning.force.com__lightning_r_Account_001j000000xlClCAAU_view-Profile_4" =
                  "SFDC";
                "chrome-app.zoom.us__wc_home-Profile_4" = "Zoom Web";
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

            "custom/battery" = {
              exec = pkgs.writeShellScript "waybar_battery" ''
                NUM="$(cat /sys/class/power_supply/BAT0/capacity | tr -d '\n')"
                STATE="$(cat /sys/class/power_supply/BAT0/status | tr -d '\n')"
                BAT=""  # fa-battery-empty
                if   [ "$STATE" = "Charging" ]; then
                    BAT=""  # fa-battery-charging
                elif [ "$STATE" = "Discharging" ]; then
                    if   [ "$NUM" -gt "95" ]; then
                        BAT=""  # fa-battery-full
                    elif [ "$NUM" -gt "85" ]; then
                        BAT=""  # fa-battery-three-quarters
                    elif [ "$NUM" -gt "70" ]; then
                        BAT=""  # fa-battery-half
                    elif [ "$NUM" -gt "60" ]; then
                        BAT=""  # fa-battery-half
                    elif [ "$NUM" -gt "50" ]; then
                        BAT=""  # fa-battery-half
                    elif [ "$NUM" -gt "40" ]; then
                        BAT=""  # fa-battery-quarter
                    elif [ "$NUM" -gt "30" ]; then
                        BAT=""  # fa-battery-quarter
                    elif [ "$NUM" -gt "20" ]; then
                        BAT=""  # fa-battery-quarter
                    else
                        BAT=""  # fa-battery-empty
                    fi
                fi
                printf "$BAT  $NUM%%"
              '';
              restart-interval = 5;
              tooltip = false;
            };

            pulseaudio = {
              reverse-scrolling = 1;
              format = "{volume}% {icon} {format_source}";
              alt-format = "{volume}% {icon} {format_source}";
              format-bluetooth = "{volume}% {icon} {format_source}";
              format-bluetooth-muted = "{volume}%  {icon} {format_source}";
              format-muted = "{volume}%  {format_source}";
              format-source = "{volume}% ";
              format-source-muted = "{volume}% ";
              format-icons = {
                headphone = "";
                hands-free = "";
                headset = "";
                phone = "";
                portable = "";
                car = "";
                default = [ "" "" "" ];
              };
              on-click = "pavucontrol";
              min-length = 13;
            };

            "network#interface" = {
              format-ethernet =
                "<span foreground='#91DDFF'> </span>"; # Font Awesome icon for ethernet
              format-wifi =
                "<span foreground='#91DDFF'> </span>"; # Font Awesome icon for wifi
              format-disconnected =
                "<span foreground='#FF6C6B'> Disconnected</span>"; # Font Awesome icon for disconnected
              format-connecting =
                "<span foreground='#FFDD57'> Connecting...</span>"; # Font Awesome icon for connecting
              tooltip = true;
              tooltip-format = "{ifname}: {ipaddr}";
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
                "<span foreground='#D4BFFF'>  </span>{usage}% <span foreground='#D4BFFF'>󱐌 </span>{avg_frequency}";
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
              format = "<span foreground='#A1EFD3'>{:%H:%M}</span>";
              format-alt =
                "<span foreground='#A1EFD3'>{:%Y-%m-%d}</span>"; # Added missing '>'
              tooltip = true; # Ensure tooltip is enabled
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

            tray = {
              icon-size = 16;
              spacing = 8;
            };
            "custom/showtray" = {
              # "format" = "";
              "format" = "";
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
