# TODO:
# Nvidia - https://wiki.hyprland.org/Nvidia/
#  Source - https://github.com/MatthiasBenaets/nixos-config/blob/2d9d8c7f847e586d2e2ec14ed669416e4a758ea4/rsc/archive/dwm/hyprland.nix

{ pkgs, config, lib, inputs, ... }:
let
  cfg = config.desktops.hyprland;
  hostName = builtins.getEnv "HOSTNAME";
  # Used in my home manager code at the bottom of the file.
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
  lockScript = pkgs.writeShellScript "lock-script" ''
    action=$1
    ${pkgs.pipewire}/bin/pw-cli i all | ${pkgs.ripgrep}/bin/rg running
    if [ $? == 1 ]; then
      if [ "$action" == "lock" ]; then
        ${pkgs.hyprlock}/bin/hyprlock
      elif [ "$action" == "suspend" ]; then
        ${pkgs.systemd}/bin/systemctl suspend
      fi
    fi
  '';
in {
  options = {
    desktops.hyprland.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable hyprland Desktop";
    };
  };

  config = lib.mkIf cfg.enable {
    # networking = { networkmanager.enable = true; };
    # Enable Display Manager
    services = {
      gnome.gnome-keyring.enable = true;
      greetd = {
        enable = true;
        settings = {
          default_session = {
            command =
              "${pkgs.greetd.tuigreet}/bin/tuigreet --time --time-format '%I:%M %p | %a • %h | %F' --cmd Hyprland";
            user = "greeter";
          };
        };
      };
    };

    environment = {

      variables = {
        # WLR_NO_HARDWARE_CURSORS="1"; # Needed for VM
        # WLR_RENDERER_ALLOW_SOFTWARE="1";
        XDG_CURRENT_DESKTOP = "Hyprland";
        XDG_SESSION_TYPE = "wayland";
        XDG_SESSION_DESKTOP = "Hyprland";
        # TODO: Testing
        XCURSOR_SIZE = "24";
      };

      sessionVariables = if hostName == "evo" then {
        LIBVA_DRIVER_NAME = "nvidia";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        NVD_BACKEND = "direct";
        __NV_PRIME_RENDER_OFFLOAD = "1";
        __NV_PRIME_RENDER_OFFLOAD_PROVIDER = "NVIDIA-G0";
        __VK_LAYER_NV_optimus = "NVIDIA_only";
        GBM_BACKEND = "nvidia";
        # EGL_PLATFORM = "wayland";
        # __GL_GSYNC_ALLOWED = "0";
        # __GL_VRR_ALLOWED = "0";
        # WLR_DRM_NO_ATOMIC = "1";
        # MOZ_DISABLE_RDD_SANDBOX = "1";
        # _JAVA_AWT_WM_NONREPARENTING = "1";

        # QT_QPA_PLATFORM = "wayland";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

        GDK_BACKEND = "wayland";
        WLR_NO_HARDWARE_CURSORS = "1";
        MOZ_ENABLE_WAYLAND = "1";
        NIXOS_OZONE_WL = "1";
      } else {
        # QT_QPA_PLATFORM = "wayland";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

        GDK_BACKEND = "wayland";
        WLR_NO_HARDWARE_CURSORS = "1";
        MOZ_ENABLE_WAYLAND = "1";
        NIXOS_OZONE_WL = "1";
      };

      # looking at: https://github.com/XNM1/linux-nixos-hyprland-config-dotfiles/blob/main/nixos/hyprland.nix
      systemPackages = with pkgs; [
        pyprland
        hyprpicker
        hyprcursor
        hyprlock
        hypridle
        hyprpaper
        wl-clipboard # Clipboard
        wlr-randr # Monitor Settings
        xwayland # X session
        grimblast # Screenshot
        greetd.tuigreet
        iwgtk # wifi gtk app

        # qutebrowser
        # zathura
        # mpv
        # imv
      ];
    };

    security.pam.services = {
      greetd = { enableGnomeKeyring = true; };
      hyprlock = {
        # text = "auth include system-auth";
        text = "auth include login";
        fprintAuth = if hostName == "evo" then true else false;
        enableGnomeKeyring = true;
      };

    };

    xdg.portal.config.common."org.freedesktop.impl.portal.Secret" =
      [ "gnome-keyring" ];

    programs = {
      hyprland = {
        enable = true;

      };
    };

    nix.settings = {
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };

    systemd.sleep.extraConfig = ''
      AllowSuspend=yes
      AllowHibernation=no
      AllowSuspendThenHibernate=no
      AllowHybridSleep=yes
    ''; # Clamshell Mode

    home-manager.users."${username}" = {

      wayland.windowManager = {
        hyprland = {
          enable = true;
          xwayland = { enable = true; };
          settings = {
            general = {
              border_size = 2;
              gaps_in = 3;
              gaps_out = 6;
              "col.active_border" = "#0D599F";
              "col.inactive_border" = "#595959";
              resize_on_border = true;
              hover_icon_on_border = false;
              layout = "dwindle";
              monitor = ",highres,auto,1";
              # Mirror monitor below. Get details with `hyprctl monitors`
              # monitor=HDMI-A-1,1920x1200@60,0x0,1,mirror,eDP-1
            };
            decoration = {
              rounding = 6;
              active_opacity = 1;
              inactive_opacity = 1;
              fullscreen_opacity = 1;
              drop_shadow = false;
            };
            animations = {
              enabled = true;
              bezier = [
                "overshot, 0.05, 0.9, 0.1, 1.05"
                "smoothOut, 0.5, 0, 0.99, 0.99"
                "smoothIn, 0.5, -0.5, 0.68, 1.5"
                "rotate,0,0,1,1"
              ];
              animation = [
                "windows, 1, 4, overshot, slide"
                "windowsIn, 1, 2, smoothOut"
                "windowsOut, 1, 0.5, smoothOut"
                "windowsMove, 1, 3, smoothIn, slide"
                "border, 1, 5, default"
                "fade, 1, 4, smoothIn"
                "fadeDim, 1, 4, smoothIn"
                "workspaces, 1, 4, default"
                "borderangle, 1, 20, rotate, loop"
              ];
            };
            input = {
              kb_layout = "us";
              # kb_layout=us,us
              # kb_variant=,dvorak
              # kb_options=caps:ctrl_modifier
              kb_options = "caps:escape";
              follow_mouse = 2;
              repeat_delay = 250;
              numlock_by_default = 1;
              accel_profile = "flat";
              sensitivity = 0.8;
              touchpad = if hostName == "dustin-krysak" || hostName == "evo"
              || hostName == "probook" then {
                natural_scroll = false;
                scroll_factor = 0.2;
                middle_button_emulation = true;
                tap-to-click = true;
              } else
                { };
            };
            gestures = if hostName == "dustin-krysak" || hostName == "evo"
            || hostName == "probook" then {
              workspace_swipe = true;
              workspace_swipe_fingers = 3;
              workspace_swipe_distance = 100;
              workspace_swipe_create_new = true;
            } else
              { };

            dwindle = {
              pseudotile = false;
              force_split = 2;
              preserve_split = true;
            };
            master = {
              # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
              new_is_master = true;
            };
            misc = {
              disable_hyprland_logo = true;
              disable_splash_rendering = true;
              mouse_move_enables_dpms = true;
              mouse_move_focuses_monitor = true;
              key_press_enables_dpms = true;
              background_color = "0x111111";
            };
            debug = { damage_tracking = 2; };

            "$mod" = "SUPER";
            bindm = [
              # Move/resize windows with mainMod + LMB/RMB and dragging
              "SUPER,mouse:272, movewindow"
              "SUPER,mouse:273, resizewindow"
            ];
            bind = [
              # Scroll through existing workspaces with mainMod + scroll
              "SUPER, mouse_down, workspace, e+1"
              "SUPER, mouse_up, workspace, e-1"
              # Run Menu
              "SUPER,Space,exec, pkill wofi || ${pkgs.wofi}/bin/wofi --show drun"
              # emulate alt-tab
              # "ALT, Tab, exec, hyprswitch"
              # "ALT SHIFT, Tab, exec, hyprswitch -r"
              "ALT, Tab, exec, hyprswitch --sort-recent --ignore-workspaces --ignore-monitors"
              "ALT SHIFT, Tab, exec, hyprswitch --sort-recent --ignore-workspaces --ignore-monitors -r"
              "SUPER, J, togglesplit," # dwindle
              "SUPER,Q,killactive,"
              "SUPER,Escape,exit,"
              "SUPER,F,fullscreen,"
              "SUPER,T,exec,${pkgs.alacritty}/bin/alacritty"
              "SUPERSHIFT,R,exec,${config.programs.hyprland.package}/bin/hyprctl reload"
              "SUPER,S,exec,${pkgs.systemd}/bin/systemctl suspend"
              "SUPER,L,exec,${pkgs.hyprlock}/bin/hyprlock"
              "$mod,B,exec,firefox"
              "CONTROL_ALT,O,exec,/etc/profiles/per-user/dustin/bin/screenshot-ocr.sh"
              "CONTROL_ALT,A,exec,/etc/profiles/per-user/dustin/bin/screenshot-annotate.sh"
              "CONTROL_ALT,Space,exec,/run/current-system/sw/bin/1password --quick-access"
              "ALT,P,exec,/run/current-system/sw/bin/1password --toggle"
              "SUPER,E,exec,${pkgs.vscode}/bin/code"
              ", Print, exec, grimblast copy area"
              ",XF86AudioLowerVolume,exec,${pkgs.pamixer}/bin/pamixer -d 10"
              ",XF86AudioRaiseVolume,exec,${pkgs.pamixer}/bin/pamixer -i 10"
              ",XF86AudioMute,exec,${pkgs.pamixer}/bin/pamixer -t"
              "SUPER_L,c,exec,${pkgs.pamixer}/bin/pamixer --default-source -t"
              "CTRL,F10,exec,${pkgs.pamixer}/bin/pamixer -t"
              ",XF86AudioMicMute,exec,${pkgs.pamixer}/bin/pamixer --default-source -t"
              ",XF86MonBrightnessDown,exec,${pkgs.light}/bin/light -U 10"
              ",XF86MonBrightnessUP,exec,${pkgs.light}/bin/light -A 10"
            ] ++ (
              # workspaces
              # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
              builtins.concatLists (builtins.genList (x:
                let
                  ws = let c = (x + 1) / 10;
                  in builtins.toString (x + 1 - (c * 10));
                in [
                  "$mod, ${ws}, workspace, ${toString (x + 1)}"
                  "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
                ]) 10));
          };
          systemd.variables = [ "--all" ];
        };
      };
      home.pointerCursor = {
        gtk.enable = true;
        # x11.enable = true;
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 20;
      };

      gtk = {
        enable = true;
        theme = {
          package = pkgs.flat-remix-gtk;
          name = "Flat-Remix-GTK-Grey-Darkest";
        };

        iconTheme = {
          package = pkgs.gnome.adwaita-icon-theme;
          name = "Adwaita";
        };

        font = {
          name = "Sans";
          size = 11;
        };
      };

      services = {
        gnome-keyring = {
          enable = true;
          components = [ "pkcs11" "secrets" "ssh" ];
        };
        hyprpaper = {
          enable = true;
          settings = {
            ipc = true;
            splash = false;
            preload = "$HOME/Pictures/wallpapers/skullskates.png";
            wallpaper = ",$HOME/Pictures/wallpapers/skullskates.png";
          };
        };
        hypridle = {
          enable = true;
          settings = {
            general = {
              before_sleep_cmd = "${pkgs.systemd}/bin/loginctl lock-session";
              after_sleep_cmd =
                "${config.programs.hyprland.package}/bin/hyprctl dispatch dpms on";
              ignore_dbus_inhibit = true;
              lock_cmd =
                "pidof ${pkgs.hyprlock}/bin/hyprlock || ${pkgs.hyprlock}/bin/hyprlock";
            };
            listener = [
              {
                timeout = 300;
                on-timeout = "${lockScript.outPath} lock";
              }
              {
                timeout = 1800;
                on-timeout = "${lockScript.outPath} suspend";
              }
            ];
          };
        };
      };

      programs = {
        wofi = {
          enable = true;
          settings = {
            key_forward = "Ctrl-n";
            key_backward = "Ctrl-p";
            key_expand = "Tab";
          };
        };
        hyprlock = {
          enable = true;
          settings = {
            general = {
              hide_cursor = true;
              no_fade_in = false;
              disable_loading_bar = true;
              grace = 0;
            };
            background = [{
              monitor = "";
              path = "$HOME/Pictures/wallpapers/skullskates.png";
              color = "rgba(25, 20, 20, 1.0)";
              blur_passes = 1;
              blur_size = 0;
              brightness = 0.2;
            }];
            input-field = [{
              monitor = "";
              size = "250, 60";
              outline_thickness = 2;
              dots_size = 0.2;
              dots_spacing = 0.2;
              dots_center = true;
              outer_color = "rgba(0, 0, 0, 0)";
              inner_color = "rgba(0, 0, 0, 0.5)";
              font_color = "rgb(200, 200, 200)";
              fade_on_empty = false;
              placeholder_text =
                ''<i><span foreground="##cdd6f4">Input Password...</span></i>'';
              hide_input = false;
              position = "0, -120";
              halign = "center";
              valign = "center";
            }];
            label = [{
              monitor = "";
              text = "$TIME";
              font_size = 120;
              position = "0, 80";
              valign = "center";
              halign = "center";
            }];
          };
        };
      };
    };
  };
}
