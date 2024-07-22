# https://github.com/hyprland-community/awesome-hyprland
{ user-settings, pkgs, config, lib, inputs, ... }:
let cfg = config.desktops.hyprland;
in {
  options = {
    desktops.hyprland.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable hyprland Desktop";
    };
    desktops.hyprland.laptop = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Indicate if the system is a laptop";
    };
  };

  config = lib.mkIf cfg.enable {

    users = lib.mkMerge [
      (lib.mkIf cfg.laptop {
        users."${user-settings.user.username}".extraGroups = [ "video" ];
      })
    ];

    cli = {
      foot.enable = true;
      yazi.enable = true;
    };

    services = {

      dbus = { enable = true; };

      # displayManager = { defaultSession = "SwayFX"; };

      # Configure keymap in X11
      xserver = {
        enable = true;
        xkb = {
          layout = "us";
          variant = "";
        };
      };

      gnome = {
        evolution-data-server.enable = true;
        gnome-online-accounts.enable = true;
        # Enable the gnome-keyring secrets vault.
        # Will be exposed through DBus to programs willing to store secrets
        gnome-keyring.enable = true;
      };

      gvfs.enable = true;

      accounts-daemon.enable = true;
    };

    # Might not be needed
    security = {
      polkit.enable = true;
      pam = {
        services = {
          # greetd = {
          #   enableGnomeKeyring = true;
          #   gnupg.enable = true;
          # };
        };
      };
    };

    fonts = {
      packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        font-awesome
        source-han-sans
        work-sans
      ];
      fontconfig.defaultFonts = {
        serif = [ "Work Sans" "Noto Serif" "Source Han Serif" ];
        sansSerif = [ "Work Sans" "Noto Sans" "Source Han Sans" ];
      };
    };

    environment = {
      sessionVariables = { NIXOS_OZONE_WLR = "1"; };
      systemPackages = with pkgs; [

        # Theme
        (catppuccin-gtk.override {
          accents = [ "mauve" ];
          size = "compact";
          variant = "mocha";
        })
        bibata-cursors
        papirus-icon-theme
        # Other
        wdisplays # monitor coniguration
        networkmanager
        accountsservice
        work-sans # font
        playerctl
        brightnessctl
        pulseaudio
        dbus-sway-environment
        libsecret # needed to give other apps access to gnome-keyring
        bluez
        bluez-tools
        blueman
        pavucontrol
        grim
        swappy
        satty
        sway-contrib.grimshot
        gcr # gnome keyring
        xwayland # needed for xwayland
        libnotify
        libsixel
        brightnessctl
        wtype
        wl-screenrec
        wl-clipboard
      ];
    };

    # Enable variuos programs
    programs = {

      # regreet = {
      #   enable = true;

      #   settings = {
      #     background = {
      #       # path = "${user-settings.user.wallpaper}";
      #       path = "/home/dustin/Pictures/wallpapers/red-skulls.jpg";
      #       fit = "Cover";
      #     };
      #     GTK = {
      #       # Whether to use the dark theme
      #       application_prefer_dark_theme = true;
      #       # TODO: move catppuccin to a separate module, or universal like wallpaper
      #       cursor_theme_name = "Bibata-Modern-Classic";
      #       font_name =
      #         "FiraCode Nerd Font Regular 12"; # TODO: update to work-sans
      #       icon_theme_name = "Papirus-Dark";
      #       theme_name =
      #         "catppuccin-gtk-theme-Dark-Compact-Macchiato"; # TODO: update to match theme
      #     };
      #   };
      # };
      hyprland = {
        enable = true;
        xwayland.enable = true;

      };
      seahorse.enable = true;

    };
    desktops.addons = { waybar.enable = true; };

    # xdg-desktop-portal exposes a series of D-Bus interfaces (APIs for file access, opening URIs, printing, etc)
    xdg = {

      enable = true;
      cacheHome = config.home.homeDirectory + "/.local/cache";

      mimeApps = let browser = [ "brave.desktop" ];
      in {
        enable = true;

        defaultApplications = {
          "application/x-extension-htm" = browser;
          "application/x-extension-html" = browser;
          "application/x-extension-shtml" = browser;
          "application/x-extension-xht" = browser;
          "application/x-extension-xhtml" = browser;
          "application/xhtml+xml" = browser;
          "text/html" = browser;
          "x-scheme-handler/about" = browser;
          "x-scheme-handler/ftp" = browser;
          "x-scheme-handler/http" = browser;
          "x-scheme-handler/https" = browser;
          "x-scheme-handler/unknown" = browser;

          "audio/*" = [ "mpv.desktop" ];
          "video/*" = [ "mpv.dekstop" ];
          "image/*" = [ "imv.desktop" ];
          "application/json" = browser;
          "application/pdf" = [ "sioyek.desktop" ];
          "application/epub+zip" = [ "sioyek.desktop" ];
          "application/zip" = [ "sioyek.desktop" ];
        };
      };

      userDirs = {
        enable = true;
        createDirectories = false;
        documents = "${user-settings.user.username}/docs";
        download = "${user-settings.user.username}/dloads";
        videos = "${user-settings.user.username}/vids";
        music = "${user-settings.user.username}/music";
        pictures = "${user-settings.user.username}/pics";
        extraConfig = {
          xdg_screenshots_dir = "${config.xdg.userDirs.pictures}/Screenshots";
        };
      };
      portal = {
        enable = true;
        xdgOpenUsePortal = true;
        wlr.enable = true;
        config.common = {
          # TODO - unserstand the next two lines
          default = [ "*" ];
          "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
        };
        # gtk portal needed to make gtk apps happy
        extraPortals =
          [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-hyprland ];
      };

    };

    ##### Home Manager Config options #####
    home-manager.users."${user-settings.user.username}" = {

      wayland.windowManager = {
        hyprland = {
          enable = true;
          systemd.enable = true;
          # This problem is related to systemd not importing the environment by default. It will not have knowledge of PATH, so it cannot run the commands in the services. This is the most common with user-configured services such as hypridle or swayidle.
          systemd.variables = [ "--all" ];
        };
        settings = {
          general = {
            gaps_in = 5;
            gaps_out = 15;
            border_size = 2;
            "col.active_border" =
              "rgba(2e8b57ff) rgba(87cefaff) rgba(ffec8bff) rgba(ffaeb9ff) 90deg";
            "col.inactive_border" = "0xff382D2E";
            no_border_on_floating = false; # enable border on float window
            layout = "dwindle";
          };
          misc = {
            disable_hyprland_logo = true;
            disable_splash_rendering = true;
            mouse_move_enables_dpms = true;
            enable_swallow = true;
            swallow_regex = "^(foot)$";
            vrr = false;
          };
          decoration = {
            rounding = 10;
            inactive_opacity = 0.8;
            active_opacity = 0.9;
            fullscreen_opacity = 1.0;
            dim_inactive = false;
            shadow_offset = "0 5";
            "col.shadow" = "rgba(00000099)";

            blur = {
              enabled = 1;
              size = 6;
              passes = 3;
              new_optimizations = true;
              ignore_opacity = true;
            };
          };

          animations = {
            enabled = true;
            bezier = "linear, 0.0, 0.0, 1.0, 1.0";
            animation =
              "borderangle, 1, 180, linear, loop"; # used by rainbow borders and rotating colors
          };

          dwindle = {
            pseudotile = true;
            preserve_split = true;
            force_split = true;
            no_gaps_when_only = false;
            default_split_ratio = 1.0;
            smart_split = false;
          };

          master = {
            new_on_top = false;
            allow_small_split = true;
            no_gaps_when_only = false;
          };

          gestures = {
            workspace_swipe = 1;
            workspace_swipe_distance = 400;
            workspace_swipe_invert = 1;
            workspace_swipe_min_speed_to_force = 30;
            workspace_swipe_cancel_ratio = 0.5;
          };

          bindm = [
            # mouse movements
            "$mod, mouse:272, movewindow"
            "$mod, mouse:273, resizewindow"
            "$mod alt, mouse:272, resizewindow"
          ];

          input = {
            kb_layout = "us";
            kb_variant = "colemak";
            follow_mouse = 1;
            touchpad = {
              natural_scroll = "no";
              disable_while_typing = 1;
              clickfinger_behavior = 0; # double tap > right click
              middle_button_emulation = 1;
              tap-to-click = 1;
            };

            # kb_options = "ctrl:nocaps";
          };

          "$mod" = "SUPER";

          bind = [
            "$mod, Q, exec, foot"
            "$mod, B, exec, brave"
            # "$mod, D, exec, discord"

            "$mod, Q, killactive"

            "$mod, M, exit"
            "$mod, h, movefocus, l"
            "$mod, l, movefocus, r"
            "$mod, k, movefocus, u"
            "$mod, j, movefocus, d"

            "$mod, 1, workspace, 1"
            "$mod, 2, workspace, 2"
            "$mod, 3, workspace, 3"
            "$mod, 4, workspace, 4"
            "$mod, 5, workspace, 5"
            "$mod, 6, workspace, 6"
            "$mod, 7, workspace, 7"
            "$mod, 8, workspace, 8"
            "$mod, 9, workspace, 9"
            "$mod, 0, workspace, 10"
          ];
        };
      };

      # home.file = {
      #   ".config/sway/config".source = ./build/cfg/sway/config;
      #   # ".config/sway/config.d/keybindings".source = ./build/cfg/sway/config.d/keybindings;
      #   # ".config/sway/config.d/default-keybindings".source = ./build/cfg/sway/config.d/default-keybindings;
      #   ".config/sway/config.d/test".source = ./build/cfg/sway/config.d/test;
      #   ".config/waylogout/config".source = ./build/cfg/waylogout/config;
      #   ".config/swappy/config".source = ./build/cfg/swappy/config;
      # };

      programs = {
        #   rofi = {
        #     enable = true;
        #     package = pkgs.rofi-wayland;
        #     cycle = true;
        #     font = "Liga SFMono Nerd Font 16";
        #     terminal = "${pkgs.foot}/bin/foot";
        #     extraConfig = {
        #       show-icons = true;
        #       # icon-theme = "GruvboxPlus";
        #       #   display-ssh = "󰣀 ssh:";
        #       # display-run = "󱓞 run:";
        #       # display-drun = "󰣖 drun:";
        #       # display-window = "󱂬 window:";
        #       # display-combi = "󰕘 combi:";
        #       # display-filebrowser = "󰉋 filebrowser:";

        #       # dpi =  120;
        #     };
        #   };
        #   keychain = {
        #     enable = true;
        #     # null or one of "local", "any", "local-once", "any-once"
        #     inheritType = "any";
        #     agents = [ "ssh" "gpg" ];
        #     enableBashIntegration = true;
        #     enableFishIntegration = true;
        #     keys = [ "id_rsa" "id_ed25519" ];
        #     # extraFlags = [ "--quiet" "--systemd" ];
        #   };

        hyprlock = {
          enable = true;
          settings = {
            background = [{
              path = "/home/idlip/.local/share/bg.jpg";
              blur_size = 8;
              blur_passes = 3;
            }];

            input-field = [{
              size = "300, 50";
              monitor = "";
              dots_center = true;
              shadow_passes = 2;
              outline_thickness = 3;
              dots_size = 0.3;
              dots_spacing = 0.1;
              fade_on_empty = true;
              placeholder_text = "<i>Pass</i>";
              position = "0, 200";
              halign = "center";
              valign = "bottom";
            }];

            label = [
              {
                color = "rgba(255, 255, 255, 1.0)";
                font_size = 35;
                text = ''
                  cmd[update:1000] echo "<b> "$(date +'%A, %-d %B %Y @ %T')" </b>"
                '';
                position = "0, 0";
                halign = "center";
                valign = "bottom";
              }

              {
                color = "rgba(255, 255, 255, 1.0)";
                font_size = 35;
                text = ''
                    $USER, Welcome back!
                '';
                position = "0, 100";
                halign = "center";
                valign = "bottom";
              }
            ];

            image = [{
              path = "/home/idlip/d-git/d-wallpapers/oled/one-piece.jpg";
              size = 200;
              rounding = -1;
              border_size = 2;
              reload_time = -1;
              position = "0, 350";
              halign = "center";
              valign = "bottom";
            }];

          };
        };

      };

      services = {

        hypridle = {
          enable = true;
          settings = {
            general = {
              lock_cmd =
                "pidof hyprlock || hyprlock"; # avoid starting multiple hyprlock instances.
              before_sleep_cmd = "loginctl lock-session"; # lock before suspend.
              after_sleep_cmd =
                "hyprctl dispatch dpms on"; # to avoid having to press a key twice to turn on the display.
              unlock_cmd = "notify-send 'Welcome back!'";
            };

            listener = [
              {
                timeout = 150;
                on-timeout =
                  "brightnessctl -s set 10"; # set monitor backlight to minimum, avoid 0 on OLED monitor.
                on-resume = "brightnessctl -r"; # monitor backlight restore.
              }
              {
                timeout = 210;
                on-timeout = "loginctl lock-session";
              }
              {
                timeout = 250;
                on-timeout = "hyprctl dispatch dpms off";
                on-resume = "hyprctl dispatch dpms on";
              }
              {
                timeout = 900;
                on-timeout = "systemctl suspend";
              }
            ];
          };
        };

        # Notifications
        mako = {
          enable = true;
          icons = true;
          font = "Work Sans 12";
          borderRadius = 6;
          borderSize = 2;
          # margin = "10";
          padding = "25";
          # "top-right", "top-center", "top-left", "bottom-right", "bottom-center", "bottom-left", "center"
          anchor = "top-center";
        };

        gpg-agent = {
          # pinentryPackage = pkgs.pinentry-gnome3;
          enable = true;
          enableSshSupport = true;
          enableFishIntegration = true;
        };

        # https://nixos.wiki/wiki/Bluetooth#Using_Bluetooth_headsets_with_PulseAudio
        mpris-proxy.enable = true;

        gnome-keyring = {
          enable = true;
          # components = [ "pkcs11" "secrets" "ssh" ];
          components = [ "pkcs11" "secrets" ];
        };

      };

      # ##### Theme

      home = {
        pointerCursor = {
          size = 32;
          # x11 = { enable = true; };
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Classic";
          gtk.enable = true;
        };
      };

      gtk = {

        enable = true;

        theme = {
          package = pkgs.adw-gtk3;
          name = "adw-gtk3-dark";
        };

        cursorTheme = {
          name = "Bibata-Modern-Classic";
          package = pkgs.bibata-cursors;
          size = 32;
        };

        font = {
          name = "Work Sans 12";
          package = pkgs.work-sans;
        };

        gtk2 = {
          configLocation = "${user-settings.user.home}/.gtkrc-2.0";
          extraConfig = ''
            gtk-application-prefer-dark-theme = 1
            gtk-decoration-layout = ":minimize,maximize,close"
            gtk-xft-antialias=1
            gtk-xft-hinting=1
            gtk-xft-hintstyle="hintslight"
            gtk-xft-rgba="rgb"
            # gtk-theme-name = "io.elementary.stylesheet.bubblegum"
          '';
        };

        gtk3 = {
          extraConfig = {
            gtk-application-prefer-dark-theme = 1;
            gtk-decoration-layout = ":minimize,maximize,close";
            gtk-xft-antialias = 1;
            gtk-xft-hinting = 1;
            gtk-xft-hintstyle = "hintslight";
            gtk-xft-rgba = "rgb";
          };
        };

        gtk4 = {
          extraConfig = {
            gtk-application-prefer-dark-theme = 1;
            gtk-decoration-layout = ":minimize,maximize,close";
          };
        };

        iconTheme = {
          name = "Adwaita";
          package = pkgs.gnome.adwaita-icon-theme;
        };
      };

      qt = {
        enable = true;
        # platformTheme = "gtk3";
        style.name = "adwaita-dark";
      };

    };
  };
}
