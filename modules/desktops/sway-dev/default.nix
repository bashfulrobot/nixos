# nix-community/nixpkgs-wayland: Automated, pre-built packages for Wayland (sway/wlroots) tools for NixOS. - https://github.com/nix-community/nixpkgs-wayland?tab=readme-ov-file#sway
{ user-settings, pkgs, config, lib, inputs, ... }:
let
  cfg = config.desktops.sway-dev;
  swayfx = inputs.swayfx.packages.x86_64-linux.default;
  dbus-sway-environment =
    pkgs.callPackage ./build/scripts/dbus-sway-environment.nix { };
  # https://github.com/sbulav/dotfiles/blob/b5289888c8eeaec137512f628b83e3a136da300d/nix/modules/nixos/desktop/addons/regreet/default.nix#L26
  # greetdSwayConfig = pkgs.writeText "greetd-sway-config" ''
  #   exec "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP"
  #   input "type:touchpad" {
  #     tap enabled
  #   }
  #   seat seat0 xcursor_theme Bibata-Modern-Classic 24
  #   xwayland enable

  #   bindsym Mod4+shift+e exec swaynag \
  #     -t warning \
  #     -m 'What do you want to do?' \
  #     -b 'Poweroff' 'systemctl poweroff' \
  #     -b 'Reboot' 'systemctl reboot'

  #   exec "${lib.getExe config.programs.regreet.package} -l debug; swaymsg exit"
  # '';
in {
  options = {
    desktops.sway-dev.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable sway dev Desktop";
    };
    desktops.sway-dev.laptop = lib.mkOption {
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

    # patch blueberry to work in the tray
    systemd.user.services.blueberry-tray = {
      path = with pkgs;
        [
          (blueberry.overrideAttrs (old: {
            patches = (old.patches or [ ])
              ++ [ ./build/patch/blueberry-tray-fix.patch ];
            buildInputs = old.buildInputs ++ [ pkgs.libappindicator-gtk3 ];
          }))
        ];
      script = "blueberry-tray; while true; do sleep 3600; done";
      restartIfChanged = true;
    };

    services = {

      blueman.enable = true;

      dbus = {
        enable = true;
        # Make the gnome keyring work properly
        # Pulled from: https://github.com/jnsgruk/nixos-config/blob/8e9bb39ab6bb32fbeb62a5cc722e2b9e07acb50c/host/common/desktop/hyprland.nix#L42
        packages = with pkgs; [ gcr ];
      };
      displayManager = {
        defaultSession = "sway";
      }; # end displayManager
      # Configure keymap in X11
      xserver = {
        enable = true;
        xkb = {
          layout = "us";
          variant = "";
        };
        displayManager = {
        lightdm = {
          enable = true;
          # TODO: use a separate repository for background images?
          background = "${user-settings.user.home}/Pictures/wallpaper/red-skulls.jpg";
          greeters.gtk.indicators = [ "~clock" "~session" "~power" ];
        }; # end lightdm

      }; # end displayManager
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
    }; # end services

    # Might not be needed
    security = {
      polkit.enable = true;
      pam = {
        services = {
          swaylock = { };
          # keyring does not start otherwise - enable once I go to lightdm
          lightdm.enableGnomeKeyring = true;
        };
      };
    };

    # kanshi systemd service
    systemd.user.services.kanshi = {
      description = "kanshi daemon";
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.kanshi}/bin/kanshi -c kanshi_config_file";
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
      variables = {
        # SSH_AUTH_SOCK = "/run/user/${user-settings.user.id}/keyring/ssh";
        # SSH_AUTH_SOCK = "/run/user/${user-settings.user.id}/gcr/ssh";
      };

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
        waylogout
        swayidle
        networkmanager
        accountsservice
        work-sans # font
        playerctl
        brightnessctl
        pulseaudio
        swayr
        sov # window overlay
        wob
        dbus-sway-environment
        libsecret # needed to give other apps access to gnome-keyring
        bluez
        bluez-tools
        blueman
        pavucontrol
        grim
        swappy
        satty
        cosmic-screenshot
        sway-contrib.grimshot
        sway-contrib.inactive-windows-transparency
        gcr # gnome keyring
        xwayland # needed for xwayland
        overskride # bluetooth settings
        pasystray # pulse audio tray
        networkmanagerapplet # network manager applet
      ];
    };

    # Enable variuos programs
    programs = {
      nm-applet = {
        enable = true;
        indicator = true;
      };

      sway = {
        enable = true;
        xwayland.enable = true;
        package = swayfx.overrideAttrs
          (old: { passthru.providedSessions = [ "sway" ]; });
        wrapperFeatures.gtk = true;
        extraSessionCommands = ''
          export XDG_SESSION_DESKTOP=sway
          export MOZ_ENABLE_WAYLAND=1
          export MOZ_USE_XINPUT2=1
          export XDG_SESSION_TYPE=wayland
          export XDG_CURRENT_DESKTOP=sway
          export WLR_NO_HARDWARE_CURSORS=1
          export QT_QPA_PLATFORM=wayland
          # --- Testing below
          export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
          export QT_FONT_DPI=144
          # TODO remove if not needed
          #export GNOME_KEYRING_CONTROL=/run/user/$UID/keyring
          #export SSH_AUTH_SOCK=/run/user/${user-settings.user.id}/keyring/ssh
          #export SSH_AUTH_SOCK=/run/user/${user-settings.user.id}/gcr/ssh
          #eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)

          # WLR_RENDERER_ALLOW_SOFTWARE=1
        '';
      };
      seahorse.enable = true;

    };
    desktops.addons = {
      waybar.enable = true;
      swayidle.enable = true;
    };

    # xdg-desktop-portal exposes a series of D-Bus interfaces (APIs for file access, opening URIs, printing, etc)
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      wlr.enable = true;
      # gtk portal needed to make gtk apps happy
      extraPortals =
        [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
    };

    ##### Home Manager Config options #####
    home-manager.users."${user-settings.user.username}" = {

      # Define the user systemd service
      # systemd.user = {
      #   sockets."gcr-ssh-agent" = {
      #     Unit.Description = "GCR ssh-agent wrapper";

      #     Socket = {
      #       Priority = 6;
      #       Backlog = 5;
      #       ListenStream = "%t/gcr/ssh";
      #       DirectoryMode = "0700";
      #     };

      #     Install.WantedBy = [ "sockets.target" ];
      #   };

      #   services.gcr-ssh-agent = {
      #     Unit = {
      #       Description = "GCR ssh-agent wrapper";
      #       Requires = [ "gcr-ssh-agent.socket" ];
      #     };

      #     Service = {
      #       Type = "simple";
      #       StandardError = "journal";
      #       # Use the runtime directory environment variable
      #       Environment = "SSH_AUTH_SOCK=%t/gcr/ssh";
      #       # Adjust the ExecStart path according to where the gcr-ssh-agent binary is located in NixOS
      #       ExecStart = "${pkgs.gcr}/libexec/gcr-ssh-agent %t/gcr";
      #       Restart = "on-failure";
      #     };

      #     Install = {
      #       Also = [ "gcr-ssh-agent.socket" ];
      #       WantedBy = [ "default.target" ];
      #     };
      #   };

      # };
      home.file = {
        ".config/sway/config".source = ./build/cfg/sway/config;
        # ".config/sway/config.d/keybindings".source = ./build/cfg/sway/config.d/keybindings;
        # ".config/sway/config.d/default-keybindings".source = ./build/cfg/sway/config.d/default-keybindings;
        ".config/sway/config.d/test".source = ./build/cfg/sway/config.d/test;
        ".config/waylogout/config".source = ./build/cfg/waylogout/config;
        ".config/swappy/config".source = ./build/cfg/swappy/config;
      };

      programs = {
        rofi = {
          enable = true;
          package = pkgs.rofi-wayland;
          cycle = true;
          font = "Liga SFMono Nerd Font 16";
          terminal = "${pkgs.foot}/bin/foot";
          extraConfig = { show-icons = true; };
        };
        keychain = {
          enable = true;
          # null or one of "local", "any", "local-once", "any-once"
          inheritType = "any";
          agents = [ "ssh" "gpg" ];
          enableBashIntegration = true;
          enableFishIntegration = true;
          keys = [ "id_rsa" "id_ed25519" ];
          # extraFlags = [ "--quiet" "--systemd" ];
        };

      };

      services = {
        blueman-applet.enable = true;
        pasystray.enable = true;
        network-manager-applet.enable = true;
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
        gpg-agent.pinentryPackage = pkgs.pinentry-gnome3;
        # https://nixos.wiki/wiki/Bluetooth#Using_Bluetooth_headsets_with_PulseAudio
        mpris-proxy.enable = true;
        gnome-keyring = {
          enable = true;
          # components = [ "pkcs11" "secrets" "ssh" ];
          components = [ "pkcs11" "secrets" ];
        };
      };

      # ##### THeme

      # gtk = {
      #   enable = true;
      #   cursorTheme = {
      #     name = "elementary";
      #     package = pkgs.pantheon.elementary-icon-theme;
      #     size = 32;
      #   };

      #   font = {
      #     name = "Work Sans 12";
      #     package = pkgs.work-sans;
      #   };

      #   gtk2 = {
      #     configLocation = "${user-settings.user.home}/.gtkrc-2.0";
      #     extraConfig = ''
      #       gtk-application-prefer-dark-theme = 1
      #       gtk-decoration-layout = ":minimize,maximize,close"
      #       gtk-theme-name = "io.elementary.stylesheet.bubblegum"
      #     '';
      #   };

      #   gtk3 = {
      #     extraConfig = {
      #       gtk-application-prefer-dark-theme = 1;
      #       gtk-decoration-layout = ":minimize,maximize,close";
      #     };
      #   };

      #   gtk4 = {
      #     extraConfig = {
      #       gtk-application-prefer-dark-theme = 1;
      #       gtk-decoration-layout = ":minimize,maximize,close";
      #     };
      #   };

      #   iconTheme = {
      #     name = "elementary";
      #     package = pkgs.pantheon.elementary-icon-theme;
      #   };

      #   theme = {
      #     name = "io.elementary.stylesheet.slate";
      #     package = pkgs.pantheon.elementary-gtk-theme;
      #   };
      # };

      # home.pointerCursor = {
      #   size = 32;
      #   x11 = { enable = true; };
      #   gtk.enable = true;
      # };
    };
  };
}
