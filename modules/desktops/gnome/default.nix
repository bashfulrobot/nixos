{ user-settings, pkgs, config, lib, inputs, ... }:
let
  cfg = config.desktops.gnome;

  # removes the icon from the panel. No setting currently supported in gnome extension.
  # https://github.com/pop-os/shell/issues/1274
  pop-shell-no-icon = pkgs.gnomeExtensions.pop-shell.overrideAttrs (oldAttrs: {
    postInstall = ''
      ${oldAttrs.postInstall or ""}
      substituteInPlace $out/share/gnome-shell/extensions/pop-shell@system76.com/extension.js \
        --replace "panel.addToStatusArea('pop-shell', indicator.button);" "// panel.addToStatusArea('pop-shell', indicator.button);"
    '';
  });

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
      gnome.themes.visuals.enable = true;
    };

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
      libadwaita # Adwaita libs
      pulseaudio # Need pactl for gnome ext
      gnome-tweaks # Gnome Tweaks
      pinentry-gnome3 # Gnome3 pinentry
      # Gnome Extensions
      # gnomeExtensions.user-themes # User Themes
      gnomeExtensions.prime-helper # Prime Helper
      gnomeExtensions.bluetooth-quick-connect # Bluetooth Quick Connect
      gnomeExtensions.quick-settings-audio-panel # Quick Settings Audio Panel
      # pop-shell-no-icon
      gnomeExtensions.pop-shell
      gnomeExtensions.appindicator # AppIndicator support
      gnomeExtensions.solaar-extension # Allow Solaar to support certain features on non X11 systems
      gnomeExtensions.hide-top-bar # Hide Top Bar - alt to ]just perfeciton with less optionse
      gnomeExtensions.just-perfection # Tweak Tool to Customize GNOME Shell, Change the Behavior and Disable UI Elements
      gnomeExtensions.window-calls # allows me to run my fish/zsh funciton to get the wmc_class of a window

      # Gnome apps/services
      nautilus # file manager
      adwaita-icon-theme # icon theme
      gnome.gnome-settings-daemon # settings daemon
      gnome2.GConf # configuration database system for old apps
    ];

    environment.gnome.excludePackages = (with pkgs; [
      # for packages that are pkgs.*
      gnome-tour
      gnome-connections
      cheese # photo booth
      gedit # text editor
      yelp # help viewer
      file-roller # archive manager
      geary # email reader
      gnome-photos
      gnome-system-monitor
      gnome-maps
      gnome-music
      gnome-weather
    ]) ++ (with pkgs.gnome; [
      # for packages that are pkgs.gnome.*
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

      # TODO: testing if the activation script solves this issue too.
      # defined in this file: system.activationScripts.script
      # home.file.".face" = {
      #   source = ./.face;
      #   target = ".face";
      # };

      dconf.settings = with inputs.home-manager.lib.hm.gvariant; {
        #  Set Media Keys
        "org/gnome/settings-daemon/plugins/media-keys" = {
          play = [ "AudioPlay" ];
          volume-down = [ "AudioLowerVolume" ];
          volume-mute = [ "AudioMute" ];
          volume-up = [ "AudioRaiseVolume" ];
        };

        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          enable-animations = true;
          font-antialiasing = "rgba";
          font-hinting = "full";
          locate-pointer = true;
          gtk-enable-primary-paste = true;
        };

        "org/gnome/shell/extensions/bluetooth-quick-connect" = {
          bluetooth-auto-power-on = true;
          refresh-button-on = true;
          show-battery-value-on = false;
        };

        "org/gnome/mutter" = {
          center-new-windows = true;
          edge-tiling = false; # for pop-shell
        };
        "org/gnome/mutter/keybindings" = {
          toggle-tiled-left = [ ]; # for pop-shell
          toggle-tiled-right = [ ]; # for pop-shell
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

        "org/gnome/shell/extensions/appindicator" = {
          legacy-tray-enabled = true;
          tray-pos = "right";
        };

        "org/gnome/shell/extensions/pop-shell" = {

          fullscreen-launcher = true;
          mouse-cursor-follows-active-window = false;
          show-title = false;
          smart-gaps = false;
          tile-by-default = true;
          # search = "<Super>space";
        };

        "org/gnome/shell" = {
          enabled-extensions = [
            "pop-shell@system76.com"
            "window-calls@domandoman.xyz"
            "quick-settings-audio-panel@rayzeq.github.io"
            "bluetooth-quick-connect@bjarosze.gmail.com"
            "solaar-extension@sidevesh"
            "hidetopbar@mathieu.bidon.ca"
          ];

          disabled-extensions = [
            # Normally Enabled
            "just-perfection-desktop@just-perfection" # locks up gnome after last update. Sad Face.
            "appindicatorsupport@rgcjonas.gmail.com"
            # Normally Disabled
            "GPU_profile_selector@lorenzo9904.gmail.com"
            "forge@jmmaranan.com"
            "gtk4-ding@smedius.gitlab.com"
            "window-list@gnome-shell-extensions.gcampax.github.com"
            "windowsNavigator@gnome-shell-extensions.gcampax.github.com"
            "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
            "lgbutton@glerro.gnome.gitlab.io"
            "gTile@vibou"
            "syncthing@gnome.2nv2u.com"
            "light-style@gnome-shell-extensions.gcampax.github.com"
            "user-theme@gnome-shell-extensions.gcampax.github.com"
          ];
        };

        "org/gnome/shell/extensions/hidetopbar" = {
          shortcut-keybind = "<Alt><Super>b";
          enable-active-window = false;
          enable-intellihide = false;
          keep-round-corners = true;
          mouse-sensitive = true;
        };
        "org/gnome/shell/extensions/quick-settings-audio-panel" = {
          always-show-input-slider = true;
          media-control = "move";
          merge-panel = true;
          move-master-volume = true;
          panel-position = "bottom";
        };

        "org/gnome/shell/extensions/just-perfection" = {
          accessibility-menu = false;
          app-menu = true;
          app-menu-icon = true;
          background-menu = false;
          controls-manager-spacing-size = 22;
          dash = true;
          dash-icon-size = 0;
          double-super-to-appgrid = false;
          keyboard-layout = false;
          osd = true;
          panel = false;
          panel-in-overview = true;
          panel-notification-icon = true;
          ripple-box = false;
          search = false;
          show-apps-button = true;
          startup-status = 0;
          theme = true;
          top-panel-position = 0; # top
          # top-panel-position = 1; # bottom
          weather = false;
          window-demands-attention-focus = true;
          window-menu-take-screenshot-button = false;
          window-picker-icon = true;
          window-preview-caption = false;
          window-preview-close-button = true;
          workspace = true;
          workspace-background-corner-size = 15;
          workspace-popup = true;
          workspaces-in-app-grid = false;
        };

        "org/gnome/desktop/wm/keybindings" = {
          close = [ "<Super>q" ];
          switch-applications = [ "<Alt>Tab" ];
          switch-applications-backward = [ "<Shift><Alt>Tab" ];
          # switch-windows = [ "<Alt>Tab" ];
          # switch-windows-backward = [ "<Shift><Alt>Tab" ];
          toggle-fullscreen = [ "<Super>f" ];
          # maximize = [ "<Super>m" ];
          maximize = [ ];
          unmaximize = [ ];
          switch-to-workspace-1 = [ "<Super>1" ];
          switch-to-workspace-2 = [ "<Super>2" ];
          switch-to-workspace-3 = [ "<Super>3" ];
          switch-to-workspace-4 = [ "<Super>4" ];
          switch-to-workspace-5 = [ "<Super>5" ];
          switch-to-workspace-6 = [ "<Super>6" ];
          switch-to-workspace-7 = [ "<Super>7" ];
          switch-to-workspace-8 = [ "<Super>8" ];
          switch-to-workspace-9 = [ "<Super>9" ];

          move-to-workspace-1 = [ "<Shift><Super>1" ];
          move-to-workspace-2 = [ "<Shift><Super>2" ];
          move-to-workspace-3 = [ "<Shift><Super>3" ];
          move-to-workspace-4 = [ "<Shift><Super>4" ];
          move-to-workspace-5 = [ "<Shift><Super>5" ];
          move-to-workspace-6 = [ "<Shift><Super>6" ];
          move-to-workspace-7 = [ "<Shift><Super>7" ];
          move-to-workspace-8 = [ "<Shift><Super>8" ];
          move-to-workspace-9 = [ "<Shift><Super>9" ];
          toggle-message-tray = [ "<Shift><Super>n" ];
          panel-run-dialog = [ "<Super>space" ];
          switch-input-source = [ ];
          switch-input-source-backward = [ ];
        };

        "org/gnome/shell/keybindings" = {
          show-screenshot-ui = [ "<Control><Alt>p" ];
          switch-to-application-1 = [ ];
          switch-to-application-2 = [ ];
          switch-to-application-3 = [ ];
          switch-to-application-4 = [ ];
        };

        "org/gnome/Console" = {
          theme = "auto";
          font-scale = 1.5;
          custom-font = "Liga SFMono Nerd Font 13";
        };

        "org/gnome/settings-daemon/plugins/media-keys" = {
          custom-keybindings = [
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom6/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom7/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom8/"
          ];
        };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" =
          {
            binding = "<Super>t";
            # binding = "<Super>space";
            # command = "kgx";
            command = "alacritty";
            name = "Terminal";
          };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" =
          {
            binding = "<Control><Alt>a";
            command =
              "/etc/profiles/per-user/dustin/bin/screenshot-annotate.sh";
            name = "Annotate Screenshot";
          };
        # "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" =
        #   {
        #     binding = "<Control><Alt>p";
        #     command = "/run/current-system/sw/bin/flameshot gui";
        #     name = "Flameshot";
        #   };

        # "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" =
        #   {
        #     binding = "<Control><Alt>p";
        #     command = "/run/current-system/sw/bin/flameshot gui";
        #     name = "Screenshot";
        #   };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" =
          {
            binding = "<Super>b";
            command = "chromium";
            name = "Browser";
          };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" =
          {
            binding = "<Super>e";
            command = "code";
            name = "Editor";
          };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4" =
          {
            binding = "<Control><Alt>o";
            command = "/etc/profiles/per-user/dustin/bin/screenshot-ocr.sh";
            name = "OCR Screenshot";
          };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5" =
          {
            binding = "<Control><Shift>x";
            command = "/run/current-system/sw/bin/1password --quick-access";
            name = "1password quick access";
          };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom6" =
          {
            binding = "<Alt>p";
            command = "/run/current-system/sw/bin/1password --toggle";
            name = "show 1password";
          };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom7" =
          {
            binding = "<Super>n";
            command = "/etc/profiles/per-user/dustin/bin/nautilus ~/dev";
            name = "open files in ~/dev";
          };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom8" =
          {
            binding = "<Control><Alt><Super>g";
            command = "gmail-url";
            name = "Transform gmail url to archive url on your clipboard";
          };
      };
    };
  };
}
