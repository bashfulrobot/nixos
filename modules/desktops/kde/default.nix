{ user-settings, secrets, lib, pkgs, config, ... }:
# Investigate: https://github.com/pjones/plasma-manager
let cfg = config.desktops.kde;
in {
  options = {
    desktops.kde.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable KDE Desktop.";
    };
  };

  config = lib.mkIf cfg.enable {

    services = {
      xserver.enable = true;
      displayManager = {
        sddm = {
          enable = true;
          wayland.enable = true;
        };
      };
      desktopManager.plasma6.enable = true;
    };

    environment.systemPackages = with pkgs; [
      kdePackages.kde-gtk-config
      kdePackages.kio-gdrive
      kdePackages.kaccounts-integration
      kdePackages.kaccounts-providers
    ];

    security.pam.services = { sddm.enableKwallet = true; };

    programs.dconf.enable = true;

    # environment.plasma6.excludePackages = with pkgs.kdePackages;
      # [
        #   konsole
        #   elisa
      # ];

    # Using the following example configuration, QT applications will have a look similar to the GNOME desktop, using a dark theme.
    # qt = {
    #   enable = true;
    #   platformTheme = "gnome";
    #   style.name = "adwaita-dark";
    # };
    # ALt
    # qt = {
    #   enable = true;
    #   platformTheme = "qtct";
    #   style.name = "kvantum";
    # };

    # xdg.configFile = {
    #   "Kvantum/ArcDark".source = "${pkgs.arc-kde-theme}/share/Kvantum/ArcDark";
    #   "Kvantum/kvantum.kvconfig".text = ''
    #     [General]
    #     theme=ArcDark'';
    # };

    home-manager.users."${user-settings.user.username}" = {
      imports = [ ./build/plasma-settings.nix ];
      # home.packages = with pkgs; [
      # ];
      # programs = { };

      # home.file.".config/plasma-org.kde.plasma.desktop-appletsrc" = {
      #   source = ./build/plasma-org.kde.plasma.desktop-appletsrc;
      #   target = ".config/plasma-org.kde.plasma.desktop-appletsrc";
      # };
    };

  };
}
