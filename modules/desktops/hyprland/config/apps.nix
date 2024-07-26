# https://github.com/budimanjojo/dotfiles
{ user-settings, pkgs, config, lib, inputs, ... }:
let

  cfg = config.desktops.hyprland.config.apps;

in {

  options = {
    desktops.hyprland.config.apps.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Apps needed for Hyprland";
    };
  };
  config = lib.mkIf cfg.enable {

    # https://wiki.archlinux.org/title/PCManFM
    environment = {
      systemPackages = with pkgs; [
        accountsservice
        # pcmanfm
        mate.caja-with-extensions
        mate.caja-extensions
        mate.python-caja
        grimblast
        swappy
        bemoji
        xorg.xwininfo # Get StartupWMClass from a window in xwayland
        wtype # xdotool type for wayland
        wlrctl # Command line utility for miscellaneous wlroots Wayland extensions
        # wshowkeys # Show keys pressed in wayland
        wl-clipboard # Wayland clipboard - needed for espanso
        hyprpicker # Wayland color picker
        # below adds white square to screen - bug - but about to test in hyprland
        xwaylandvideobridge # Utility to allow streaming Wayland windows to X applications
        networkmanagerapplet # NetworkManager systray applet
        pavucontrol # PulseAudio Volume Control
      ];
    };

    programs = { seahorse.enable = true; };

    cli = {
      foot.enable = true;
      yazi.enable = true;
    };

    ##### Home Manager Config options #####
    home-manager.users."${user-settings.user.username}" = {

      services.pasystray.enable = true;

      # home.file = {
      #   ".config/pcmanfm/default/pcmanfm.conf".source =
      #     ./build/cfg/pcmanfm/pcmanfm.conf;
      #   ".config/swappy/config".source = ./build/cfg/swappy/config;
      # };

    };
  };
}
