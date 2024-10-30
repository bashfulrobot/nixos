{ user-settings, lib, config, pkgs, inputs, ... }:
let
  cfg = config.desktops.gnome.extensions;

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
    desktops.gnome.extensions.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable desktops.gnome.extensions.";
    };
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      # pop-shell-no-icon
      # Gnome Extensions
      gnomeExtensions.user-themes # User Themes
      # gnomeExtensions.prime-helper # Prime Helper
      gnomeExtensions.bluetooth-quick-connect # Bluetooth Quick Connect
      gnomeExtensions.quick-settings-audio-panel # Quick Settings Audio Panel
      gnomeExtensions.caffeine # Prohibit Sleep
      # Below can remove title bars
      gnomeExtensions.unite # Unite is a GNOME Shell extension which makes a few layout tweaks to the top panel and removes window decorations to make it look like Ubuntu Unity Shell

      gnomeExtensions.pop-shell
      gnomeExtensions.appindicator # AppIndicator support
      gnomeExtensions.solaar-extension # Allow Solaar to support certain features on non X11 systems
      #gnomeExtensions.hide-top-bar # Hide Top Bar - alt to ]just perfeciton with less optionse
      gnomeExtensions.just-perfection # Tweak Tool to Customize GNOME Shell, Change the Behavior and Disable UI Elements
      gnomeExtensions.window-calls # allows me to run my fish/zsh funciton to get the wmc_class of a window

    ];

    home-manager.users."${user-settings.user.username}" = {
      dconf.settings = with inputs.home-manager.lib.hm.gvariant; {

        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          enable-animations = true;
          font-antialiasing = "rgba";
          font-hinting = "full";
          locate-pointer = true;
          gtk-enable-primary-paste = true;
          # TODO: might not be needed with Stylix
          gtk-theme = "Adwaita"; # breaks stylix on build
          # gtk-theme = "adw-gtk3"; # currently broken, but needed in stylix.
          icon-theme = "Adwaita";
          cursor-theme = "Adwaita";
        };

        "org/gnome/shell" = {
          # Enabled extensions
          enabled-extensions = [

            "window-calls@domandoman.xyz"
            "quick-settings-audio-panel@rayzeq.github.io"
            "bluetooth-quick-connect@bjarosze.gmail.com"
            "solaar-extension@sidevesh"
            "appindicatorsupport@rgcjonas.gmail.com"
            "caffeine@patapon.info"
            "user-theme@gnome-shell-extensions.gcampax.github.com"
            "just-perfection-desktop@just-perfection" # locks up gnome after last update. Sad Face. Testing
            "pop-shell@system76.com"
            "unite@hardpixel.eu"
          ];

          # Disabled extensions
          disabled-extensions = [
            # Normally Enabled

            "lilypad@shendrew.github.io"
            # Normally Disabled
            "hidetopbar@mathieu.bidon.ca"
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
          ];
        };

        # Begin gnome shell extension settings

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
          keyboard-layout = false;
          osd = true;
          panel = true;
          panel-in-overview = true;
          panel-notification-icon = true;
          ripple-box = false;
          search = false;
          show-apps-button = true;
          startup-status = 0;
          theme = true;
          # top-panel-position = 0; # top
          top-panel-position = 1; # bottom
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
          double-super-to-appgrid = true;
        };

        "ong/gnome/shell/extensions/caffeine" = {
          enable-fullscreen = false;
          duration-timer = 2;
        };

        "ong/gnome/shell/extensions/unite" = {
          hide-window-titlebars = "always";
          show-window-title = "always";
          extend-left-box = false;
          reduce-panel-spacing = true;
          greyscale-tray-icons = true;
          show-appmenu-button = false;
          hide-app-menu-icon = true;
          use-activities-text = false;
          show-desktop-name = false;
          autofocus-windows = true;
          enable-titlebar-actions = false;
          window-buttons-theme = "default";
        };

        "org/gnome/shell/extensions/hidetopbar" = {
          shortcut-keybind = "<Alt><Super>b";
          enable-active-window = false;
          enable-intellihide = false;
          keep-round-corners = true;
          mouse-sensitive = true;
        };

        "org/gnome/shell/extensions/bluetooth-quick-connect" = {
          bluetooth-auto-power-on = true;
          refresh-button-on = true;
          show-battery-value-on = false;
        };

        "org/gnome/shell/extensions/appindicator" = {
          legacy-tray-enabled = true;
          tray-pos = "right";
        };

        # TODO: move to nixpkg once packaged
        "org/gnome/shell/extensions/lilypad" = {
          lilypad-order = [
            "StatusNotifierItem"
            "appindicator-legacy:Todoist:9486"
            "appindicator-org.kde.StatusNotifierItem-18233-2"
            "appindicator-org.kde.StatusNotifierItem-21611-2"
            "sni"
            "appindicator-org.blueman.Tray"
            "pop-shell"
          ];
          reorder = false;
          rightbox-order = [ "lilypad" ];
          show-icons = false;
        };

        "org/gnome/shell/extensions/pop-shell" = {
          active-hint = false;
          hint-color-rgba = "rgb(122, 162, 247)";
          # gaps need to be the same.
          gap-inner = mkUint32 4;
          gap-outer = mkUint32 4;
          smart-gaps = false;
          active-hint-border-radius = mkUint32 0;
          show-title = false;
          show-skip-taskbar = false;
        };

      };

      # window exceptions
      home.file.".config/pop-shell/config.json".text = ''
        {
          "float": [
            {
              "class": "pop-shell-example",
              "title": "pop-shell-example"
            },
            {
              "class": "firefox",
              "title": "^(?!.*Mozilla Firefox).*$",
              "disabled": true
            },
            {
              "class": "zoom",
              "disabled": false
            },
            {
              "class": "Slack",
              "disabled": true
            },
            {
              "class": "Element",
              "disabled": false
            },
            {
              "class": "1Password",
              "disabled": false
            },
            {
              "class": "chrome-chat.developer.gov.bc.ca__channel_devops-sysdig-Default",
              "disabled": false
            }

          ],
          "skiptaskbarhidden": [],
          "log_on_focus": false
        }

      '';

    };

  };
}
