{ user-settings, secrets, lib, pkgs, config, inputs, ... }:
let
  cfg = config.desktops.budgie;
  setAudioInOut = pkgs.writeShellApplication {
    name = "set-audio-in-out";

    runtimeInputs = [ ];

    text = ''
      #!/run/current-system/sw/bin/env bash

      # Extract the card ID for the Shure MV7 device
      card_id=$(pactl list short cards | /run/current-system/sw/bin/grep 'Shure_Inc_Shure_MV7' | awk '{print $1}')

      # Set the profile to "Digital Stereo (IEC958) Output + Mono Input"
      pactl set-card-profile "$card_id" output:iec958-stereo+input:mono-fallback

      # Get the ID for "Shure MV7 Digital Stereo"
      sink_id=$(wpctl status | /run/current-system/sw/bin/grep 'Shure MV7 Digital Stereo' | /run/current-system/sw/bin/grep -oP '\d{1,3}' | head -n 1)

      # Get the ID for "Shure MV7 Mono"
      source_id=$(wpctl status | /run/current-system/sw/bin/grep -A 1 'Shure MV7 Mono' | /run/current-system/sw/bin/grep -oP '\d{1,3}' | head -n 1)

      # Set the default sink and source
      wpctl set-default "$sink_id"

      wpctl set-default "$source_id"

      # Send notification
      notify-send "Audio inputs set."

      exit 0
    '';
  };
in {
  options = {
    desktops.budgie.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Budgie Desktop.";
    };
    desktops.budgie.enableHIDPI = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Budgie HiDPi Support.";
    };

  };

  config = lib.mkIf cfg.enable {

    services = {

      dbus.enable = true;
      gnome.gnome-keyring.enable = true;
      gvfs.enable = true;

      xserver = {
        enable = true;
        excludePackages = [ pkgs.xterm ];

        # Configure keymap in X11
        xkb = {
          layout = "us";
          variant = "";
        };

        desktopManager.budgie = {
          enable = true;
          extraPlugins = [ pkgs.budgiePlugins.budgie-media-player-applet ];
        };

        displayManager.lightdm = {
          enable = true;
          background =
            "/home/dustin/.local/share/backgrounds/3pio-bender-catppuccin-mocha.png";
          greeters.slick = {
            enable = true;
            theme.name = "catppuccin-mocha-sky-compact+black,rimless,normal";
            iconTheme.name = "Tela-black-dark";
            cursorTheme.name = "Bibata-Modern-Ice";
            draw-user-backgrounds = false;
            extraConfig = ''
              ${if config.desktops.budgie.enableHIDPI then
                "enable-hidpi = on;"
              else
                ""}
            '';
          };
        };
      };

    };
    desktops.budgie.keybindings.enable = true;

    xdg = {
      portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      };
    };

    environment = {
      systemPackages = with pkgs; [
        # valid options can be seen here - https://github.com/NixOS/nixpkgs/blob/7ce8e7c4cf90492a631e96bcfe70724104914381/pkgs/data/themes/catppuccin-gtk/default.nix#L16
        (catppuccin-gtk.override {
          accents = [
            "blue"
            "flamingo"
            "green"
            "lavender"
            "maroon"
            "mauve"
            "peach"
            "pink"
            "red"
            "rosewater"
            "sapphire"
            "sky"
            "teal"
            "yellow"
          ]; # You can specify multiple accents here to output multiple themes
          size = "compact"; # "standard" "compact"
          tweaks = [
            "black"
            "rimless"
            "normal"
          ]; # You can also specify multiple tweaks here
          variant = "mocha"; # "latte" "frappe" "macchiato" "mocha"
        })
        satty
        catppuccin-cursors
        catppuccin-papirus-folders
        catppuccinifier-gui
        catppuccinifier-cli
        work-sans
        tela-icon-theme
        tela-circle-icon-theme
        pulseaudio
        setAudioInOut
      ];
      budgie.excludePackages = with pkgs; [ gnome.gnome-terminal ];
    };

    security = { pam.services = { lightdm.enableGnomeKeyring = true; }; };

    programs.dconf.enable = true;
    sys.catppuccin-theme.enable = true;

    # wpctl status - look for proper ID
    #  wpctl set-default ID - by id it knows sink our source.
    hardware.pulseaudio = {
      extraConfig = ''
        set-default-sink alsa_output.usb-Shure_Inc_Shure_MV7-00.analog-stereo
        set-default-source alsa_output.usb-Shure_Inc_Shure_MV7-00.analog-stereo.monitor
      '';
    };

    system.activationScripts.script.text = ''
      mkdir -p /var/lib/AccountsService/{icons,users}
      cp ${user-settings.user.home}/dev/nix/nixos/modules/desktops/gnome/.face /var/lib/AccountsService/icons/${user-settings.user.username}
      echo -e "[User]\nIcon=/var/lib/AccountsService/icons/${user-settings.user.username}\n" > /var/lib/AccountsService/users/${user-settings.user.username}

      chown root:root /var/lib/AccountsService/users/${user-settings.user.username}
      chmod 0600 /var/lib/AccountsService/users/${user-settings.user.username}

      chown root:root /var/lib/AccountsService/icons/${user-settings.user.username}
      chmod 0444 /var/lib/AccountsService/icons/${user-settings.user.username}
    '';

    home-manager.users."${user-settings.user.username}" = {

      home.file."3pio-bender-catppuccin-mocha.png" = {
        source = ../../sys/wallpapers/3pio-bender-catppuccin-mocha.png;
        target = ".local/share/backgrounds/3pio-bender-catppuccin-mocha.png";
      };

      # Create the satty.desktop file in the home folder
      # home.file.".local/share/applications/satty.desktop".text = ''
      #   [Desktop Entry]
      #   Name=Satty
      #   Exec=satty %f
      #   Type=Application
      #   Terminal=true
      #   MimeType=image/png;
      # '';

      home.sessionVariables.XDG_CURRENT_DESKTOP = "Budgie:GNOME";

      services.gnome-keyring = {
        enable = true;
        # Ensure all are enabled. Could not find docs
        # stating the defaults.
        components = [ "pkcs11" "secrets" "ssh" ];
      };

      home.file.".face.icon" = {
        source = ./.face.icon;
        target = ".face.icon";
      };

      home.file.".face" = {
        source = ./.face;
        target = ".face";
      };

      dconf.settings = with inputs.home-manager.lib.hm.gvariant; {

        "com.solus-project.budgie-panel:Budgie" = {
          pinned-launchers = [
            "chromium.desktop"
            "code.desktop"
            "slack.desktop"
            "alacritty.desktop"
            "minder.desktop"
          ];
        };

        "com/solus-project/budgie-wm" = {
          enable-unredirect = true;
          show-all-windows-tabswitcher = true;
          edge-tiling = true;
        };

        # TODO: Rfactor panel ID into variables for desktop/laptop
        # Rembot
        "com/solus-project/budgie-panel/panels/{d4f8eb0a-a16d-11ef-af99-2cf05da6ad16}" =
          {
            dock-mode = false;
            theme-regions = true;
            enable-shadow = false;
            transparency = "none";
            spacing = 4;
            size = 24;
          };

        # Evo
        "com/solus-project/budgie-panel/panels/{d86965e4-a15e-11ef-afa7-e02e0b11348d}" =
          {
            dock-mode = false;
            theme-regions = true;
            enable-shadow = false;
            transparency = "none";
            spacing = 4;
            size = 24;
          };

        # Rembot
        "com/solus-project/budgie-panel/instance/budgie-menu/{d4fe5324-a16d-11ef-af99-2cf05da6ad16}" =
          {
            menu-compact = true;
            menu-show-control-center-items = true;
            enable-menu-label = false;
            menu-icon = "/home/dustin/dev/nix/nixos/modules/desktops/budgie/budgie-menu.png";
          };

        # Laptop
        "com/solus-project/budgie-panel/instance/budgie-menu/{d86d18f6-a15e-11ef-afa7-e02e0b11348d}" =
          {
            menu-compact = true;
            menu-show-control-center-items = true;
            enable-menu-label = false;
            menu-icon = "/home/dustin/dev/nix/nixos/modules/desktops/budgie/budgie-menu.png";
          };

        "com/solus-project/budgie-panel" = {
          notification-position = "BUDGIE_NOTIFICATION_POSITION_BOTTOM_RIGHT";
          dark-theme = true;
          builtin-theme = true;
          enable-animations = true;
        };

        "org/buddiesofbudgie/budgie-desktop-view" = {
          show = false;
          click-policy = "double";
        };

        "org/gnome/mutter" = { edge-tiling = true; };

        "org/gnome/desktop/wm/preferences" = {
          num-workspaces = 4;
          titlebar-font = "Work Sans Bold 10";
        };

        "org/gnome/desktop/peripherals/mouse" = { natural-scroll = false; };
        "org/gnome/desktop/peripherals/touchpad" = { natural-scroll = false; };

        "org/gnome/desktop/interface" = {
          font-name = "Work Sans 12";
          document-font-name = "Work Sans 12";
          monospace-font-name = "UbuntuSansMono Nerd Font 10";
          font-hinting = "full";
          font-antialiasing = "rgba";
          gtk-theme = "catppuccin-mocha-sky-compact+black,rimless,normal";
          icon-theme = "Tela-black-dark";
          cursor-theme = "Bibata-Modern-Ice";
          color-scheme = "prefer-dark";
          clock-format = "24h";
        };

        "org/gnome/desktop/background" = {
          picture-uri =
            "file:///home/dustin/.local/share/backgrounds/3pio-bender-catppuccin-mocha.png";
          picture-uri-dark =
            "file:///home/dustin/.local/share/backgrounds/3pio-bender-catppuccin-mocha.png";
          color-shading-type = "solid";
          picture-options = "zoom";
          primary-color = "#000000";
          secondary-color = "#000000";
        };

        "org/gnome/desktop/screensaver" = {
          picture-uri =
            "file:///home/dustin/.local/share/backgrounds/3pio-bender-catppuccin-mocha.png";
          # color-shading-type = "solid";
          picture-options = "zoom";
          # primary-color = "#000000";
          # secondary-color = "#000000";
        };

      };

    };

  };
}
