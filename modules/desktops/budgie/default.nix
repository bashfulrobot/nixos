{ user-settings, secrets, lib, pkgs, config, inputs, ... }:
# Investigate: https://github.com/pjones/plasma-manager
let cfg = config.desktops.budgie;
in {
  options = {
    desktops.budgie.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Budgie Desktop.";
    };
  };

  config = lib.mkIf cfg.enable {

    services = {

      dbus.enable = true;
      gnome.gnome-keyring.enable = true;

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
          # extraPlugins = [
          #   pkgs.budgie-analogue-clock-applet
          #   pkgs.budgie-user-indicator-redux
          #   pkgs.budgie-media-player-applet
          # ];
        };

        displayManager.lightdm = {
          enable = true;
          background = "/var/lib/wallpaper/bobby285271/current.jpg";
          greeters.slick = {
            enable = true;
            theme.name = "Qogir-Dark";
            iconTheme.name = "Qogir";
            cursorTheme.name = "Qogir";
            draw-user-backgrounds = false;
            extraConfig = ''
              enable-hidpi = on
            '';
          };

        };
      };

    };

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
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
        catppuccin-cursors
        catppuccin-papirus-folders
        catppuccinifier-gui
        catppuccinifier-cli
        work-sans
      ];
      budgie.excludePackages = with pkgs;
        [

        ];
    };

    security.pam.services.lightdm.enableKwallet = true;

    programs.dconf.enable = true;
    sys.catppuccin-theme.enable = true;

    home-manager.users."${user-settings.user.username}" = {

      home.file."3pio-bender-catppuccin-mocha.png" = {
        source = ../../sys/wallpapers/3pio-bender-catppuccin-mocha.png;
        target = ".local/share/backgrounds/3pio-bender-catppuccin-mocha.png";
      };

      home.sessionVariables.XDG_CURRENT_DESKTOP = "Budgie:GNOME";

      services.gnome-keyring = {
        enable = true;
        # Ensure all are enabled. Could not find docs
        # stating the defaults.
        components = [ "pkcs11" "secrets" "ssh" ];
      };

      dconf.settings = with inputs.home-manager.lib.hm.gvariant; {
        "com/solus-project/budgie-wm" = {
          enable-unredirect = true;
          show-all-windows-tabswitcher = true;
          edge-tiling = true;
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

        "org/gnome/desktop/wm/preferences" = { num-workspaces = 4; };

        "org/gnome/desktop/interface" = {
          font-name = "Work Sans 12";
          document-font-name = "Work Sans 12";
          monospace-font-name = "Source Code Pro 10";
          font-hinting = "full";
          font-antialiasing = "rgba";
          gtk-theme = "catppuccin-mocha-sky-compact+black,rimless,normal";
          icon-theme = "Tela-dark";
          cursor-theme = "Bibata-Modern-Ice";
          color-scheme = "prefer-dark";
        };

        "org/gnome/desktop/background" = {
          picture-uri = "file:///home/dustin/.local/share/backgrounds/3pio-bender-catppuccin-mocha.png";
          picture-uri-dark = "file:///home/dustin/.local/share/backgrounds/3pio-bender-catppuccin-mocha.png";
          color-shading-type = "solid";
          picture-options = "zoom";
          primary-color = "#000000";
          secondary-color = "#000000";
        };

        "org/gnome/desktop/screensaver" = {
          picture-uri = "file:///home/dustin/.local/share/backgrounds/3pio-bender-catppuccin-mocha.png";
          # color-shading-type = "solid";
          picture-options = "zoom";
          # primary-color = "#000000";
          # secondary-color = "#000000";
        };

      };

    };

  };
}
