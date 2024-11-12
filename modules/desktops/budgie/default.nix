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
      systemPackages = with pkgs;
        [

        ];
      budgie.excludePackages = with pkgs;
        [

        ];
    };

    security.pam.services.lightdm.enableKwallet = true;

    programs.dconf.enable = true;
    desktops.addons.wayland.enable = true;
    sys.catppuccin-theme.enable = true;

    home-manager.users."${user-settings.user.username}" = {

      home.sessionVariables.XDG_CURRENT_DESKTOP = "Budgie:GNOME";

      services.gnome-keyring = {
        enable = true;
        # Ensure all are enabled. Could not find docs
        # stating the defaults.
        components = [ "pkcs11" "secrets" "ssh" ];
      };

      dconf.settings = with inputs.home-manager.lib.hm.gvariant;
        {

        };

      # home.file.".config/plasma-org.kde.plasma.desktop-appletsrc" = {
      #   source = ./build/plasma-org.kde.plasma.desktop-appletsrc;
      #   target = ".config/plasma-org.kde.plasma.desktop-appletsrc";
      # };
    };

  };
}
