{ user-settings, secrets, lib, pkgs, config, inputs, ... }:
let
  cfg = config.desktops.xfce;

  toggleProjecteur = pkgs.writeShellApplication {
    name = "toggle-projecteur";

    runtimeInputs = [ ];

    text = ''
      #!/run/current-system/sw/bin/env bash
      # if ! pgrep -x "projecteur" > /dev/null; then
      #   projecteur &
      #   sleep 3
      # fi
      projecteur -c preset=dk -c spot=toggle
      exit 0
    '';
  };

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
    desktops.xfce.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable XFCE Desktop.";
    };
  };

  config = lib.mkIf cfg.enable {

    services = {

      dbus.enable = true;
      gnome.gnome-keyring.enable = true;
      gvfs.enable = true;

      xserver = {
        enable = true;

        # Configure keymap in X11
        xkb = {
          layout = "us";
          variant = "";
        };

        desktopManager.xfce = {
          enable = true;
        };

        displayManager = {
        defaultSession = "xfce";
        lightdm = {
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
                "enable-hidpi = on;"
            '';
          };
          };
        };
      };

    };
    # desktops.xfce.keybindings.enable = true;

    xdg = {
      portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      };
    };

    environment = {
      systemPackages = with pkgs; [

        # Other packages
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
        devilspie2 # Good tutorial - https://www.linux-magazine.com/Issues/2017/205/Tutorial-Devilspie2
        setAudioInOut
        toggleProjecteur
        ulauncher # launcher
      ];
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

      home.file = {

        ".config/autostart/ulauncher.desktop".text = ''
          [Desktop Entry]
          Version=1.0
          Name=Ulauncher
          Comment=Application launcher for Linux
          Exec=ulauncher --hide-window
          Icon=ulauncher
          Terminal=false
          Type=Application
          Categories=Utility;
          StartupNotify=false
        '';

        ".config/autostart/projecteur.desktop".text = ''
          [Desktop Entry]
          Type=Application
          Exec=/run/current-system/sw/bin/projecteur
          Name=Projecteur
          GenericName=Linux/X11 application for the Logitech Spotlight device.
          Icon=projecteur
          Terminal=false
          Categories=Office;Presentation;

        '';

        ".config/Projecteur/Projecteur.conf".text = ''
          [General]
          borderColor=@Variant(\0\0\0\x43\x1\xff\xff\xff\xff\xc3\xc3\0\0\0\0)
          borderSize=8
          cursor=13
          dotColor=@Variant(\0\0\0\x43\x1\xff\xff\xff\xff\0\0\0\0\0\0)
          enableZoom=true
          multiScreenOverlay=false
          shadeColor=@Variant(\0\0\0\x43\x1\xff\xff\"\"\"\"\"\"\0\0)
          shadeOpacity=0.5
          showBorder=true
          showCenterDot=false
          spotShape=spotshapes/Circle.qml
          spotSize=24
          zoomFactor=2.5

          [Preset_dk]
          Shape.Ngon\sides=3
          Shape.Square\radius=20
          Shape.Star\innerRadius=50
          Shape.Star\points=5
          borderColor=@Variant(\0\0\0\x43\x1\xff\xff\xff\xff\xc3\xc3\0\0\0\0)
          borderOpacity=0.8
          borderSize=8
          cursor=13
          dotColor=@Variant(\0\0\0\x43\x1\xff\xff\xff\xff\0\0\0\0\0\0)
          dotOpacity=0.8
          dotSize=5
          enableZoom=true
          multiScreenOverlay=false
          shadeColor=@Variant(\0\0\0\x43\x1\xff\xff\"\"\"\"\"\"\0\0)
          shadeOpacity=0.5
          showBorder=true
          showCenterDot=false
          showSpotShade=true
          spotRotation=0
          spotShape=spotshapes/Circle.qml
          spotSize=48
          zoomFactor=2.5
        '';
      };

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

      # home.sessionVariables.XDG_CURRENT_DESKTOP = "Budgie:GNOME";

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

    };

  };
};
}
