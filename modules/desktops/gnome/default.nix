{ user-settings, pkgs, config, lib, inputs, ... }:
let cfg = config.desktops.gnome;

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
    desktops.gnome.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Gnome Desktop";
    };
  };

  config = lib.mkIf cfg.enable {

    desktops = {
      addons = {
        # Enable Wayland specific settings
        wayland.enable = true;
      };
      gnome = {
        extensions.enable = true;
        keybindings.enable = true;
        themes.visuals.enable = true;
      };
    };

    sys = {
      catppuccin-theme.enable = true;
    };

    apps = { nautilus.enable = true; };

    xdg.portal.config.common.default = [ "*" ];

    services.xserver = {
      enable = true;
      # Enable the GNOME Desktop Environment.
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;

      # Configure keymap in X11
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    environment.systemPackages = with pkgs; [
      setAudioInOut # Set audio input/output
      libadwaita # Adwaita libs
      adwaita-qt6 # Adwaita Qt theme
      adwaita-icon-theme # Adwaita icons
      vscode-extensions.piousdeer.adwaita-theme # Adwaita Theme for VSCode
      gnome-randr # Xrandr-like CLI for configuring displays on GNOME/Wayland, on distros that don't support `wlr-randr`
      gnome-firmware # Firmware updater
      pulseaudio # Need pactl for gnome ext
      gnome-tweaks # Gnome Tweaks
      pinentry-gnome3 # Gnome3 pinentry
      # Gnome apps/services
      gnome-settings-daemon # settings daemon
      gnome2.GConf # configuration database system for old apps
    ];

    # TODO: generates error.
    #  error: undefined variable 'gnome-maps'
    environment.gnome.excludePackages = (with pkgs; [
      # for packages that are pkgs.*
      gnome-tour
      gnome-connections
      cheese # photo booth
      gedit # text editor
      yelp # help viewer
      file-roller # archive manager
      gnome-photos
      gnome-system-monitor
      gnome-maps
      gnome-music
      gnome-weather
      epiphany
    ]) ++ (with pkgs.gnomeExtensions; [
      # for packages that are pkgs.gnomeExtensions.*
      applications-menu
      auto-move-windows
      gtk4-desktop-icons-ng-ding
      launch-new-instance
      light-style
      native-window-placement
      next-up
      places-status-indicator
      removable-drive-menu
      screenshot-window-sizer
      window-list
      windownavigator
      workspace-indicator
      hide-top-bar
    ]);

    system.activationScripts.script.text = ''
      mkdir -p /var/lib/AccountsService/{icons,users}
      cp ${user-settings.user.home}/dev/nix/nixos/modules/desktops/gnome/.face /var/lib/AccountsService/icons/${user-settings.user.username}
      echo -e "[User]\nIcon=/var/lib/AccountsService/icons/${user-settings.user.username}\n" > /var/lib/AccountsService/users/${user-settings.user.username}

      chown root:root /var/lib/AccountsService/users/${user-settings.user.username}
      chmod 0600 /var/lib/AccountsService/users/${user-settings.user.username}

      chown root:root /var/lib/AccountsService/icons/${user-settings.user.username}
      chmod 0444 /var/lib/AccountsService/icons/${user-settings.user.username}
    '';

    # MUTTER PATCH--------------------------------------------------------------
    # NOTE - this could be something to watch as gnome updates
    #
    # Currently breaks my build with Stylix.
    #
    # More info (Dynamic triple buffering) - https://wiki.nixos.org/wiki/GNOME
    # nixpkgs.overlays = [
    #   # GNOME 46: triple-buffering-v4-46
    #   (final: prev: {
    #     gnome = prev.gnome.overrideScope (gnomeFinal: gnomePrev: {
    #       mutter = gnomePrev.mutter.overrideAttrs (old: {
    #         src = pkgs.fetchFromGitLab {
    #           domain = "gitlab.gnome.org";
    #           owner = "vanvugt";
    #           repo = "mutter";
    #           rev = "triple-buffering-v4-46";
    #           hash = "sha256-fkPjB/5DPBX06t7yj0Rb3UEuu5b9mu3aS+jhH18+lpI=";
    #         };
    #       });
    #     });
    #   })
    # ];

    # nixpkgs.config.allowAliases = false;
    # MUTTER PATCH--------------------------------------------------------------

    ##### Home Manager Config options #####
    home-manager.users."${user-settings.user.username}" = {
      home.sessionVariables = { XDG_CURRENT_DESKTOP = "gnome"; };

      services.gnome-keyring = {
        enable = true;
        # Ensure all are enabled. Could not find docs
        # stating the defaults.
        components = [ "pkcs11" "secrets" "ssh" ];
      };

      dconf.settings = with inputs.home-manager.lib.hm.gvariant; {

        "org/gnome/mutter" = {
          center-new-windows = true;
          edge-tiling = false; # for pop-shell
        };

        "org/gnome/desktop/peripherals/touchpad" = {
          two-finger-scrolling-enabled = true;
          edge-scrolling-enabled = false;
          tap-to-click = true;
          natural-scroll = false;
          disable-while-typing = true;
          click-method = "fingers";
        };

        "org/gnome/desktop/peripherals/mouse" = { natural-scroll = false; };

        "org/gnome/settings-daemon/plugins/color" = {
          night-light-enabled = true;
        };

        "org/gnome/Console" = {
          theme = "auto";
          font-scale = 1.5;
          custom-font = "Liga SFMono Nerd Font 13";
        };

      };

    };
  };
}
