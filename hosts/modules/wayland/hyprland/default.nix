{ config, osConfig, pkgs, lib, ... }:

let
  hostname = config.networking.hostName;

  isDustinLaptop = hostname == "dustin-krysak";

  laptopPackages = if isDustinLaptop then [ pkgs.batsignal ] else [ ];
in {

  programs.hyprland.enable = true;
  #environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs;
    [
      alacritty # gpu accelerated terminal
      ironbar # hyprland waybar alt
      wayland
      xdg-utils # for opening default programs when clicking links
      glib # gsettings
      gnome3.adwaita-icon-theme # default gnome cursors
      # swaylock
      swaylock-effects # swaylock fork
      swayidle
      grim # screenshot functionality
      slurp # screenshot functionality
      swappy # Screenshot editor
      wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
      # rofi-wayland # installed via home-manager
      mako # notification system developed by swaywm maintainer
      wdisplays # tool to configure displays
      unzip # compression tool
      pulseaudio # volume keys
      pavucontrol # volume control panel
      pasystray # audio sys tray
      blueberry # bluetooth cfg
      pamixer # pulse audio
      networkmanagerapplet # network manager sys tray
      # waybar # Swaybar alt - installed via home-manager
      brightnessctl # display brightness
      playerctl # media keys
      gnome.gnome-keyring # keyring
    ] ++ laptopPackages;

  # Used for keyring in sway
  services.gnome.gnome-keyring.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # xdg-desktop-portal works by exposing a series of D-Bus interfaces
  # known as portals under a well-known name
  # (org.freedesktop.portal.Desktop) and object path
  # (/org/freedesktop/portal/desktop).
  # The portal interfaces include APIs for file access, opening URIs,
  # printing and others.
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
  };

  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
  };

  # Hardware Support for Wayland Sway
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
    };
  };

  # Swaylock cannot unlock with correct password
  security.pam.services.swaylock.text = ''
    # PAM configuration file for the swaylock screen locker. By default, it includes
    # the 'login' configuration file (see /etc/pam.d/login)
    auth include login
  '';

  # Needed for sway with home-manager
  security.polkit.enable = true;

  # create systemd unit for batsignal if this is my laptop
  systemd.user.services = if isDustinLaptop then {
    batsignal = {
      enable = true;
      description = "Battery status daemon";
      script = "${pkgs.batsignal}/bin/batsignal";
    };
  } else
    { };

}
