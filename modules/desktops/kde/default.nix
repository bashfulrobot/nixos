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

    services.xserver.enable = true;
    services.displayManager.sddm.enable = true;
    services.xserver.displayManager.sddm.wayland.enable = true;
    services.displayManager.sddm.wayland.enable = true;
    services.desktopManager.plasma6.enable = true;

    environment.plasma6.excludePackages = with pkgs.kdePackages;
      [
        #   plasma-browser-integration
        #   konsole
        #   elisa
      ];

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

      home.packages = with pkgs; [ ];
      programs = { };
    };

  };
}
