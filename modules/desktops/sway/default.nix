# nix-community/nixpkgs-wayland: Automated, pre-built packages for Wayland (sway/wlroots) tools for NixOS. - https://github.com/nix-community/nixpkgs-wayland?tab=readme-ov-file#sway
{ user-settings, pkgs, config, lib, ... }:
let
  cfg = config.desktops.sway;
  # https://github.com/emersion/xdg-desktop-portal-wlr/wiki/"It-doesn't-work"-Troubleshooting-Checklist
  # note: this is pretty much the same as  /etc/sway/config.d/nixos.conf but also restarts
  # some user services to make sure they have the correct environment variables
  dbus-sway-environment =
    pkgs.callPackage ./build/scripts/dbus-sway-environment.nix { };
  lockman = pkgs.callPackage ./build/scripts/lockman.nix { };
  # dbus-sway-environment = pkgs.writeShellApplication {
  #   name = "dbus-sway-environment";

  #   runtimeInputs = [ ];

  #   text = ''
  #       #!/usr/bin/env bash

  #     dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
  #     systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
  #     systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
  #   '';
  # };
  # lockman = pkgs.writeShellApplication {
  #   name = "lockman";

  #   runtimeInputs = [ ];

  #   text = ''
  #     #!/usr/bin/env bash

  #     # Times the screen off and puts it to background
  #       swayidle \
  #         timeout 10 'swaymsg "output * dpms off"' \
  #         resume 'swaymsg "output * dpms on"' &
  #     # Locks the screen immediately
  #       swaylock --indicator --indicator-radius 100 --indicator-thickness 7 --effect-blur 7x5 --effect-vignette 0.5:0.5 --grace 2 --fade-in 0.2
  #       # Kills last background task so idle timer doesn't keep running
  #       kill %%

  #       exit 0
  #   '';
  # };
in {
  options = {
    desktops.sway.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable sway Desktop";
    };
    desktops.sway.laptop = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Indicate if the system is a laptop";
    };
  };

  config = lib.mkIf cfg.enable {

    users = lib.mkMerge [
      (lib.mkIf cfg.laptop {
        users."${user-settings.user.username}".extraGroups = [ "video" ];
        # programs.light.enable = true;
        # Additional laptop-specific configurations can go here
      })
    ];

    cli = {
      foot.enable = true;
      yazi.enable = true;
    };

    services = {
      displayManager = {
        defaultSession = "sway";
        sddm = {
          enable = true;
          wayland.enable = true;
          autoNumlock = true;
          package = pkgs.kdePackages.sddm;

        };
      };
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
      # greetd = {
      #   enable = true;
      #   settings = {
      #     default_session = {
      #       command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
      #       user = "greeter";
      #     };
      #   };
      # };
    };
    # Might not be needed
    security = {
      polkit.enable = true;
      pam = {
        services = {
          sddm.enableGnomeKeyring = true;
          # greetd = { enableGnomeKeyring = true; };
          swaylock = { };
          # keyring does not start otherwise - enable once I go to lightdm
          # lightdm.enableGnomeKeyring = true;
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
        # source-han-sans-japanese
        # source-han-serif-japanese
        work-sans
      ];
      fontconfig.defaultFonts = {
        serif = [ "Work Sans" "Noto Serif" "Source Han Serif" ];
        sansSerif = [ "Work Sans" "Noto Sans" "Source Han Sans" ];
      };
    };

    environment = {

      systemPackages = with pkgs; [
        waylogout
        swayidle
        networkmanager
        accountsservice
        work-sans # font
        light
        pulseaudio
        wob
        dbus-sway-environment
        lockman
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
      ];
    };

    # Enable variuos programs
    programs = {
      sway = {
        enable = true;
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
            export GNOME_KEYRING_CONTROL=/run/user/$UID/keyring
            export SSH_AUTH_SOCK=/run/user/$UID/keyring/ssh
            eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh);
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
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-wlr
        ];
    };

    ##### Home Manager Config options #####
    home-manager.users."${user-settings.user.username}" = {

      home.file = {
        ".config/sway/config".source = ./build/cfg/sway/config;
        ".config/waylogout/config".source = ./build/cfg/waylogout/config;
        ".config/swappy/config".source = ./build/cfg/swappy/config;
      };

      programs.rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
        cycle = true;
        font = "Liga SFMono Nerd Font 16";
        terminal = "${pkgs.foot}/bin/foot";
        extraConfig = {
          show-icons = true;
          # icon-theme = "GruvboxPlus";
          #   display-ssh = "󰣀 ssh:";
          # display-run = "󱓞 run:";
          # display-drun = "󰣖 drun:";
          # display-window = "󱂬 window:";
          # display-combi = "󰕘 combi:";
          # display-filebrowser = "󰉋 filebrowser:";

          # dpi =  120;
        };

      };

      programs.tofi = {
        enable = true;
        settings = {
          anchor = "top";
          width = "100%";
          height = 30;
          horizontal = true;
          prompt-text = " run: ";
          outline-width = 0;
          border-width = 0;
          min-input-width = 120;
          result-spacing = 15;
          padding-top = 0;
          padding-bottom = 0;
          padding-left = 0;
          padding-right = 0;
          font = "Work Sans";
          font-size = 12;
        };
      };
      services = {
        mako.enable = true;
        gpg-agent.pinentryPackage = pkgs.pinentry-gnome3;
        # https://nixos.wiki/wiki/Bluetooth#Using_Bluetooth_headsets_with_PulseAudio
        mpris-proxy.enable = true;
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
