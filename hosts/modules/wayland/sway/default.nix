{ config, osConfig, pkgs, lib, ... }:

let
  hostname = config.networking.hostName;

  isDustinLaptop = hostname == "dustin-krysak";

  laptopPackages = if isDustinLaptop then [ pkgs.batsignal ] else [ ];

  # bash script to let dbus know about important env variables and
  # propagate them to relevent services run at the end of sway config
  # see
  # https://github.com/emersion/xdg-desktop-portal-wlr/wiki/"It-doesn't-work"-Troubleshooting-Checklist
  # note: this is pretty much the same as  /etc/sway/config.d/nixos.conf but also restarts
  # some user services to make sure they have the correct environment variables
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };

  # currently, there is some friction between sway and gtk:
  # https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
  # the suggested way to set gtk settings is with gsettings
  # for gsettings to work, we need to tell it where the schemas are
  # using the XDG_DATA_DIR environment variable
  # run at the end of sway config
  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text = let
      schema = pkgs.gsettings-desktop-schemas;
      datadir = "${schema}/share/gsettings-schemas/${schema.name}";
    in ''
      export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
      gnome_schema=org.gnome.desktop.interface
      gsettings set $gnome_schema gtk-theme 'adw-gtk3'
    '';
  };

in {

  environment.systemPackages = with pkgs;
    [
      alacritty # gpu accelerated terminal
      dbus-sway-environment
      configure-gtk
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
      # swaybg # wallpapers
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
      swayr # window switcher
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

  # enable sway window manager
  programs.sway = {
    enable = true;
    # package = pkgs.swayfx;
    wrapperFeatures.gtk = true;
    extraSessionCommands = ''
      export WLR_RENDERER_ALLOW_SOFTWARE=1
    '';
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
