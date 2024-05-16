# { lib, config, inputs, pkgs, ... }:
{ pkgs, config, lib, inputs, ... }:
let
  cfg = config.desktops.gnome;
  # Used in my home manager code at the bottom of the file.
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {
  options = {
    desktops.gnome.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Gnome Desktop";
    };
  };

  config = lib.mkIf cfg.enable {

    desktops.gnome.themes.nord.enable = true;

    xdg.portal.config.common.default = [ "*" ];

    services.xserver.enable = true;

    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    # Configure keymap in X11
    services.xserver = {
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    environment.systemPackages = with pkgs; [
      libadwaita # Adwaita libs
      gnome.gnome-tweaks # Gnome Tweaks
      pinentry-gnome3 # Gnome3 pinentry
      # Gnome Extensions
      gnomeExtensions.user-themes # User Themes
      gnomeExtensions.bluetooth-quick-connect # Bluetooth Quick Connect
      gnomeExtensions.just-perfection # Just Perfection
      # gnomeExtensions.fly-pie # Fly Pie mouse menu
      # gnomeExtensions.paperwm # tilig window manager
      gnomeExtensions.blur-my-shell # Blur my Shell
      gnomeExtensions.quick-settings-audio-panel # Quick Settings Audio Panel
      gnomeExtensions.pop-shell # Pop Shell
      gnomeExtensions.appindicator # AppIndicator support
      gnomeExtensions.do-not-disturb-while-screen-sharing-or-recording # Automatically switches on the "Do Not Disturb" mode while screen sharing or screen recording. As soon as screen sharing/recording is over, "Do Not Disturb" mode will be switched back off.
      # gnomeExtensions.easyScreenCast # Simplifies the use of the video recording function integrated in gnome shell
      gnomeExtensions.fullscreen-notifications # Enables all notifications in fullscreen mode
      gnomeExtensions.undecorate # Add undecorate item in window menu. Use ALT+Space to show window menu
      gnomeExtensions.solaar-extension # Allow Solaar to support certain features on non X11 systems
      gnomeExtensions.just-perfection # Tweak Tool to Customize GNOME Shell, Change the Behavior and Disable UI Elements
      gnomeExtensions.looking-glass-button # Toggle the Looking Glass visibility by clicking on a panel icon.

      ## Extentions to try, or diusabled due to gnome shell version
      #gnomeExtensions.next-up # Show your next calendar event in the status bar
      #gnomeExtensions.hide-top-bar # Hide the top bar except in overview
      # gnomeExtensions.gtk4-desktop-icons-ng-ding # Libadwaita/Gtk4 port of Desktop Icons NG with GSconnect Integration, Drag and Drop on to Dock or Dash.
      # gnomeExtensions.gtk-title-bar # Remove title bars for non-GTK apps with minimal interference with the default workflow
      # gnomeExtensions.toggle-alacritty # Toggles Alacritty window via hotkey: Alt+z
      # Screenshot Directory
      # Hide Top Bar
      # Grand Theft Focus
      # gnomeExtensions.unite # Unite
      # gnomeExtensions.forge
      # gnomeExtensions.syncthing-indicator # Shell indicator for starting, monitoring and controlling the Syncthing daemon using SystemD
      # gnomeExtensions.syncthing-icon # Display Syncthing Icon in Top Bar
      # gnomeExtensions.gsconnect # GSConnect

      # Gnome apps/services
      gnome.nautilus # file manager
      gnome.adwaita-icon-theme # icon theme
      gnome.gnome-settings-daemon # settings daemon
      gnome2.GConf # configuration database system for old apps

    ];

    environment.gnome.excludePackages = with pkgs; [
      gnome.cheese # photo booth
      gedit # text editor
      gnome.yelp # help viewer
      gnome.file-roller # archive manager
      gnome.geary # email client

      # these should be self explanatory
      gnome.gnome-maps
      gnome.gnome-music
      gnome-photos
      gnome.gnome-system-monitor
      gnome.gnome-weather

      # disable gnome extensions
      gnomeExtensions.applications-menu
      gnomeExtensions.auto-move-windows
      gnomeExtensions.gtk4-desktop-icons-ng-ding
      gnomeExtensions.hide-top-bar
      gnomeExtensions.launch-new-instance
      gnomeExtensions.light-style
      gnomeExtensions.native-window-placement
      gnomeExtensions.next-up
      gnomeExtensions.places-status-indicator
      gnomeExtensions.removable-drive-menu
      gnomeExtensions.screenshot-window-sizer
      gnomeExtensions.window-list
      gnomeExtensions.windownavigator
      gnomeExtensions.workspace-indicator
    ];
    #   Dynamic triple buffering
    # Big merge request against Mutter improves the performance of the window manager by a lot (and is already used by Ubuntu). Not merged into nixpkgs due to philosophy of nixpkgs, but users are free to add this overlay to get it too.

    # Currently it's adapted for Gnome 45.
    # nixpkgs.overlays = [
    #   (final: prev: {
    #     gnome = prev.gnome.overrideScope' (gnomeFinal: gnomePrev: {
    #       mutter = gnomePrev.mutter.overrideAttrs (old: {
    #         src = pkgs.fetchgit {
    #           url = "https://gitlab.gnome.org/vanvugt/mutter.git";
    #           # GNOME 45: triple-buffering-v4-45
    #           rev = "0b896518b2028d9c4d6ea44806d093fd33793689";
    #           sha256 = "sha256-mzNy5GPlB2qkI2KEAErJQzO//uo8yO0kPQUwvGDwR4w=";
    #         };
    #       });
    #     });
    #   })
    # ];

    # You might need to disable aliases to make Dynamic triple buffering work:
    # nixpkgs.config.allowAliases = false;

    ##### Home Manager Config options #####
    home-manager.users."${username}" = {

      home.sessionVariables = {
        XDG_CURRENT_DESKTOP = "gnome";
      };

      home.file.".face" = {
        source = ./.face;
        target = ".face";
      };

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

        "org/gnome/desktop/sound" = { theme-name = "Yaru"; };

        "org/gnome/shell/extensions/libpanel" = {
          row-spacing = 24;
          padding = 20;
        };

        "org/gnome/shell/extensions/unite" = {
          desktop-name-text = "rembot";
          enable-titlebar-actions = true;
          extend-left-box = false;
          greyscale-tray-icons = true;
          hide-activities-button = "always";
          hide-app-menu-icon = true;
          hide-dropdown-arrows = true;
          hide-window-titlebars = "maximized";
          notifications-position = "right";
          reduce-panel-spacing = false;
          show-desktop-name = false;
          show-legacy-tray = true;
          show-window-buttons = "maximized";
          show-window-title = "never";
          window-buttons-theme = "auto";
        };

        "org/gnome/shell/extensions/bluetooth-quick-connect" = {
          bluetooth-auto-power-on = true;
          refresh-button-on = true;
          show-battery-value-on = false;
        };

        "org/gnome/shell/extensions/blur-my-shell" = {
          brightness = 0.7;
          sigma = 35;
        };

        "org/gnome/shell/extensions/blur-my-shell/hidetopbar" = {
          compatibility = false;
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
          tap-to-click = false;
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
          active-hint = true;
          active-hint-border-radius = mkUint32 4;
          fullscreen-launcher = true;
          mouse-cursor-follows-active-window = false;
          show-title = true;
          smart-gaps = true;
          tile-by-default = true;

        };

        "org/gnome/shell" = {
          enabled-extensions = [
            "quick-settings-audio-panel@rayzeq.github.io"
            "unite@hardpixel.eu"
            "appindicatorsupport@rgcjonas.gmail.com"
            "bluetooth-quick-connect@bjarosze.gmail.com"
            "blur-my-shell@aunetx"
            "just-perfection-desktop@just-perfection"
            "user-theme@gnome-shell-extensions.gcampax.github.com"
            # "forge@jmmaranan.com"
            "pop-shell@system76.com"
            "do-not-disturb-while-screen-sharing-or-recording@marcinjahn.com"
            "fullscreen-notifications@sorrow.about.alice.pm.me"
            "solaar-extension@sidevesh"
            "undecorate@sun.wxg@gmail.com"
            "GPU_profile_selector@lorenzo9904.gmail.com"
          ];
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
          move-to-workspace-1 = [ "<Shift><Super>1" ];
          move-to-workspace-2 = [ "<Shift><Super>2" ];
          move-to-workspace-3 = [ "<Shift><Super>3" ];
          move-to-workspace-4 = [ "<Shift><Super>4" ];
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
        };

        "org/gnome/shell/extensions/do-not-disturb-while-screen-sharing-or-recording" =
          {
            dnd-on-screen-recording = true;
            dnd-on-screen-sharing = true;
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
            binding = "<Super>t";
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
            command = "firefox";
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

      };
    };
  };
}
