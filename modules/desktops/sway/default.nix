# nix-community/nixpkgs-wayland: Automated, pre-built packages for Wayland (sway/wlroots) tools for NixOS. - https://github.com/nix-community/nixpkgs-wayland?tab=readme-ov-file#sway
{ user-settings, pkgs, config, lib, inputs, ... }:
let
  cfg = config.desktops.sway;
  swayfx = inputs.swayfx.packages.x86_64-linux.default;
  dbus-sway-environment =
    pkgs.callPackage ./build/scripts/dbus-sway-environment.nix { };
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
      })
    ];

    cli = {
      foot.enable = true;
      yazi.enable = true;
    };

    services = {
      displayManager = {
        defaultSession = "SwayFX";
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
      # example gtk-greetd config - https://github.com/kira-bruneau/nixos-config/blob/ecd48379a1632be76fb75825312a3c9bce1228e4/environments/gui/sway.nix#L35
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
        playerctl
        brightnessctl
        pulseaudio
        swayr
        wob
        dbus-sway-environment
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
        package = swayfx.overrideAttrs (old: { passthru.providedSessions = [ "sway" ]; });
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
      extraPortals =
        [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
    };

    ##### Home Manager Config options #####
    home-manager.users."${user-settings.user.username}" = {

      home.file = {
        ".config/sway/config".source = ./build/cfg/sway/config;
        # ".config/sway/config.d/keybindings".source = ./build/cfg/sway/config.d/keybindings;
        # ".config/sway/config.d/default-keybindings".source = ./build/cfg/sway/config.d/default-keybindings;
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
