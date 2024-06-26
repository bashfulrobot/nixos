# https://github.com/wimpysworld/nix-config/blob/main/nixos/_mixins/desktop/pantheon/default.nix - much pilphered from here
{ user-settings, pkgs, config, lib, inputs, ... }:
let
  cfg = config.desktops.pantheon;
  # Used in my home manager code at the bottom of the file.

in {
  options = {
    desktops.pantheon.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable pantheon Desktop";
    };
  };

  config = lib.mkIf cfg.enable {

    # Disable autoSuspend; my Pantheon session kept auto-suspending
    # - https://discourse.nixos.org/t/why-is-my-new-nixos-install-suspending/19500
    # displayManager.gdm.autoSuspend = if (desktop == "pantheon") then true else false;

    xdg.portal = {
      config = {
        pantheon = {
          default = [ "pantheon" "gtk" ];
          "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
        };
        # common.default = [ "*" ];
      };
    };

    # TODO: add option to enable/disable auto-suspend
    # will need to use merge with the other config in xserver.displayManager.gdm.autoSuspend
    security = {
      #     # Disable autoSuspend; my Pantheon session kept auto-suspending
      #     # - https://discourse.nixos.org/t/why-is-my-new-nixos-install-suspending/19500
      #     polkit.extraConfig = ''
      #       polkit.addRule(function(action, subject) {
      #           if (action.id == "org.freedesktop.login1.suspend" ||
      #               action.id == "org.freedesktop.login1.suspend-multiple-sessions" ||
      #               action.id == "org.freedesktop.login1.hibernate" ||
      #               action.id == "org.freedesktop.login1.hibernate-multiple-sessions")
      #           {
      #               return polkit.Result.NO;
      #           }
      #       });
      #     '';
      # keyring does not start otherwise
      pam.services.lightdm.enableGnomeKeyring = true;
    };

    services = {
      gnome = {
        evolution-data-server.enable = true;
        gnome-online-accounts.enable = true;
        gnome-keyring.enable = true;
      };
      gvfs.enable = true;

      # Configure keymap in X11
      xserver = {
        enable = true;
        xkb = {
          layout = "us";
          variant = "";
        };

        displayManager = {

          lightdm.enable = true;
          lightdm.greeters.pantheon.enable = true;

          # TODO: add option to enable/disable auto-suspend
          # Disable autoSuspend; my Pantheon session kept auto-suspending
          # - https://discourse.nixos.org/t/why-is-my-new-nixos-install-suspending/19500
          # gdm.autoSuspend = if (desktop == "pantheon") then true else false;

        };
        desktopManager = {
          pantheon = {
            enable = true;
            extraWingpanelIndicators = with pkgs; [
              wingpanel-indicator-ayatana
              monitor
            ];
          };

        };

      };

      # TODO: add option to enable/disable flatpak remote for elementary apps
      # Add the flatpak remote for elementary apps
      flatpak.remotes = [{
        name = "appcenter";
        location = "https://flatpak.elementary.io/repo.flatpakrepo";
      }];

    };

    environment = {

      # App indicator
      # - https://discourse.nixos.org/t/anyone-with-pantheon-de/28422
      # - https://github.com/NixOS/nixpkgs/issues/144045#issuecomment-992487775
      pathsToLink = [ "/libexec" ];

      systemPackages = with pkgs; [
        yaru-theme
        appeditor
        formatter
        pick-colour-picker
        pantheon-tweaks
        accountsservice
      ];
      pantheon.excludePackages = with pkgs; [ pkgs.pantheon.epiphany ];
    };

    # Enable variuos programs
    programs = {
      evince.enable = true;
      gnome-disks.enable = true;
      pantheon-tweaks.enable = true;
      seahorse.enable = true;

    };

    #  QT settings
    qt = {
      enable = true;
      platformTheme = "gnome";
      style = "adwaita-dark";
    };

    # App indicator
    # - https://github.com/NixOS/nixpkgs/issues/144045#issuecomment-992487775
    systemd.user.services.indicator-application-service = {
      description = "indicator-application-service";
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart =
          "${pkgs.indicator-application-gtk3}/libexec/indicator-application/indicator-application-service";
      };
    };

    services.accounts-daemon.enable = true;

    ##### Home Manager Config options #####
    home-manager.users."${user-settings.user.username}" = {

      home.sessionVariables = { XDG_CURRENT_DESKTOP = "Pantheon"; };

      home.file.".face" = {
        source = ./.face;
        target = ".face";
      };

      services = {
        gpg-agent.pinentryPackage = pkgs.pinentry-gnome3;
        # https://nixos.wiki/wiki/Bluetooth#Using_Bluetooth_headsets_with_PulseAudio
        mpris-proxy.enable = true;
      };

      gtk = {
        enable = true;
        cursorTheme = {
          name = "elementary";
          package = pkgs.pantheon.elementary-icon-theme;
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
            gtk-theme-name = "io.elementary.stylesheet.bubblegum"
          '';
        };

        gtk3 = {
          extraConfig = {
            gtk-application-prefer-dark-theme = 1;
            gtk-decoration-layout = ":minimize,maximize,close";
          };
        };

        gtk4 = {
          extraConfig = {
            gtk-application-prefer-dark-theme = 1;
            gtk-decoration-layout = ":minimize,maximize,close";
          };
        };

        iconTheme = {
          name = "elementary";
          package = pkgs.pantheon.elementary-icon-theme;
        };

        theme = {
          name = "io.elementary.stylesheet.slate";
          package = pkgs.pantheon.elementary-gtk-theme;
        };
      };

      home.pointerCursor = {
        package = pkgs.pantheon.elementary-icon-theme;
        name = "elementary";
        size = 32;
        gtk.enable = true;
        x11.enable = true;
      };

      home.file = {
        "${user-settings.user.home}/autostart/ibus-daemon.desktop".text = ''

          [Desktop Entry]
          Name=IBus Daemon
          Comment=IBus Daemon
          Type=Application
          Exec=${pkgs.ibus}/bin/ibus-daemon --daemonize --desktop=pantheon --replace --xim
          Categories=
          Terminal=false
          NoDisplay=true
          StartupNotify=false'';

        "${user-settings.user.home}/autostart/monitor.desktop".text = ''

          [Desktop Entry]
          Name=Monitor Indicators
          Comment=Monitor Indicators
          Type=Application
          Exec=/run/current-system/sw/bin/com.github.stsdc.monitor --start-in-background
          Icon=com.github.stsdc.monitor
          Categories=
          Terminal=false
          StartupNotify=false'';
      };

      systemd.user.services = {
        # https://github.com/tom-james-watson/emote
        emote = {
          Unit = { Description = "Emote"; };
          Service = {
            ExecStart = "${pkgs.emote}/bin/emote";
            Restart = "on-failure";
          };
          Install = { WantedBy = [ "default.target" ]; };
        };
      };

      dconf.settings = with inputs.home-manager.lib.hm.gvariant; {
        "com/github/stsdc/monitor/settings" = {
          background-state = true;
          indicator-state = true;
          indicator-cpu-state = false;
          indicator-gpu-state = false;
          indicator-memory-state = false;
          indicator-network-download-state = true;
          indicator-network-upload-state = true;
          indicator-temperature-state = true;
        };
        "desktop/ibus/panel" = {
          show-icon-on-systray = false;
          use-custom-font = true;
          custom-font = "Work Sans 10";
        };

        "desktop/ibus/panel/emoji" = { font = "Noto Color Emoji 16"; };

        "io/elementary/code/saved-state" = { outline-visible = true; };

        "io/elementary/desktop/agent-geoclue2" = { location-enabled = true; };

        # TODO: Do I like this?
        "io/elementary/desktop/wingpanel" = { use-transparency = true; };

        "io/elementary/desktop/wingpanel/keyboard" = { capslock = true; };

        "io/elementary/desktop/wingpanel/datetime" = { clock-format = "24h"; };

        "io/elementary/desktop/wingpanel/sound" = {
          max-volume = mkDouble 100.0;
        };

        "io/elementary/files/preferences" = {
          singleclick-select = true;
          restore-tabs = false;
        };

        "io/elementary/notifications/applications/gala-other" = {
          remember = false;
          sounds = false;
        };

        "io/elementary/settings-daemon/datetime" = { show-weeks = true; };

        "io/elementary/settings-daemon/housekeeping" = {
          cleanup-downloads-folder = false;
        };

        "io/elementary/terminal/settings" = {
          audible-bell = false;
          background = "rgb(18,18,20)";
          cursor-color = "rgb(255,182,56)";
          follow-last-tab = "true";
          font = "FiraCode Nerd Font Mono Medium 13";
          foreground = "rgb(200,200,200)";
          natural-copy-paste = false;
          palette =
            "rgb(20,20,23):rgb(214,43,43):rgb(65,221,117):rgb(255,182,56):rgb(40,169,255):rgb(230,109,255):rgb(20,229,211):rgb(200,200,200):rgb(67,67,69):rgb(222,86,86):rgb(161,238,187):rgb(255,219,156):rgb(148,212,255):rgb(243,182,255):rgb(161,245,238):rgb(233,233,233)";
          theme = "custom";
          unsafe-paste-alert = false;
        };

        "net/launchpad/plank/docks/dock1" = {
          alignment = "center";
          hide-mode = "window-dodge";
          icon-size = mkInt32 48;
          pinned-only = false;
          position = "left";
          theme = "Transparent";
          pressure-reveal = true;
        };

        "org/gnome/desktop/background" = {
          picture-uri =
            "file:///run/current-system/sw/share/backgrounds/odin-dark.jpg";
          picture-uri-dark =
            "file:///run/current-system/sw/share/backgrounds/odin-dark.jpg";
          color-shading-type = "unset";
          picture-options = "zoom";
          # primary-color = "#000000";
          # secondary-color = "#000000";
        };

        "org/gnome/desktop/datetime" = { automatic-timezone = true; };

        "org/gnome/desktop/interface" = {
          locate-pointer = true;
          clock-format = "24h";
          color-scheme = "prefer-dark";
          # cursor-size = mkInt32 32;
          cursor-theme = "elementary";
          document-font-name = "Work Sans 12";
          font-name = "Work Sans 12";
          gtk-theme = "io.elementary.stylesheet.slate";
          gtk-enable-primary-paste = true;
          icon-theme = "elementary";
          monospace-font-name = "FiraCode Nerd Font Mono Medium 13";
          text-scaling-factor = mkDouble 1.0;
        };

        "org/gnome/desktop/peripherals/touchpad" = { natural-scroll = false; };

        "org/gnome/desktop/session" = { idle-delay = mkInt32 900; };

        "org/gnome/desktop/sound" = { theme-name = "elementary"; };

        "org/gnome/desktop/wm/keybindings" = {
          close = [ "<Super>q" ];
          switch-to-workspace-1 = [ "<Super>1" "<Control><Alt>Home" ];
          switch-to-workspace-2 = [ "<Super>2" ];
          switch-to-workspace-3 = [ "<Super>3" ];
          switch-to-workspace-4 = [ "<Super>4" ];
          switch-to-workspace-5 = [ "<Super>5" ];
          switch-to-workspace-6 = [ "<Super>6" ];
          switch-to-workspace-7 = [ "<Super>7" ];
          switch-to-workspace-8 = [ "<Super>8" ];
          switch-to-workspace-down = [ "<Control><Alt>Down" ];
          switch-to-workspace-last = [ "<Control><Alt>End" ];
          switch-to-workspace-left = [ "<Control><Alt>Left" ];
          switch-to-workspace-right = [ "<Control><Alt>Right" ];
          switch-to-workspace-up = [ "<Control><Alt>Up" ];
          move-to-workspace-1 = [ "<Super><Shift>1" ];
          move-to-workspace-2 = [ "<Super><Shift>2" ];
          move-to-workspace-3 = [ "<Super><Shift>3" ];
          move-to-workspace-4 = [ "<Super><Shift>4" ];
          move-to-workspace-5 = [ "<Super><Shift>5" ];
          move-to-workspace-6 = [ "<Super><Shift>6" ];
          move-to-workspace-7 = [ "<Super><Shift>7" ];
          move-to-workspace-8 = [ "<Super><Shift>8" ];
          move-to-workspace-down = [ "<Super><Alt>Down" ];
          move-to-workspace-last = [ "<Super><Alt>End" ];
          move-to-workspace-left = [ "<Super><Alt>Left" ];
          move-to-workspace-right = [ "<Super><Alt>Right" ];
          move-to-workspace-up = [ "<Super><Alt>Up" ];
        };

        "org/gnome/desktop/wm/preferences" = {
          audible-bell = false;
          button-layout = ":minimize,maximize,close";
          titlebar-font = "Work Sans Semi-Bold 12";
        };

        "org/gnome/GWeather" = { temperature-unit = "centigrade"; };

        "org/gnome/mutter" = {
          workspaces-only-on-primary = false;
          dynamic-workspaces = false;
        };

        "org/gnome/mutter/keybindings" = {
          toggle-tiled-left = [ "<Super>Left" ];
          toggle-tiled-right = [ "<Super>Right" ];
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
          ];
        };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" =
          {
            binding = "<Super>e";
            command = "code";
            name = "Editor";
          };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" =
          {
            binding = "<Super>t";
            command = "alacritty";
            name = "Terminal";
          };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" =
          {
            binding = "<Super>b";
            command = "firefox";
            name = "Browser";
          };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" =
          {
            binding = "<Control><Alt>a";
            command =
              "/etc/profiles/per-user/dustin/bin/screenshot-annotate.sh";
            name = "Annotate Screenshot";
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

        "org/gnome/settings-daemon/plugins/power" = {
          power-button-action = "interactive";
          sleep-inactive-ac-timeout = mkInt32 0;
          sleep-inactive-ac-type = "nothing";
        };

        #"org/gnome/settings-daemon/plugins/xsettings" = {
        #  overrides = "{\'Gtk/DialogsUseHeader\': <0>, \'Gtk/ShellShowsAppMenu\': <0>, \'Gtk/EnablePrimaryPaste\': <1>, \'Gtk/DecorationLayout\': <\':minimize,maximize,menu\'>, \'Gtk/ShowUnicodeMenu\': <0>}";
        #};

        "org/gtk/gtk4/Settings/FileChooser" = { clock-format = "24h"; };

        "org/gtk/Settings/FileChooser" = { clock-format = "24h"; };

        "org/pantheon/desktop/gala/appearance" = {
          button-layout = ":minimize,maximize,close";
        };

        "org/pantheon/desktop/gala/behavior" = {
          dynamic-workspaces = false;
          overlay-action =
            "io.elementary.wingpanel --toggle-indicator=app-launcher";
        };

        "org/pantheon/desktop/gala/mask-corners" = { enable = false; };
      };
    };
  };
}
