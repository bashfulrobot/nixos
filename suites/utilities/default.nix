{ config, pkgs, lib, user-settings, ... }:
let cfg = config.suites.utilities;
in {

  options = {
    suites.utilities.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable system level utilities (tools)..";
    };
  };

  config = lib.mkIf cfg.enable {
    cli = { };

    apps = { };

    environment.systemPackages = with pkgs; [
      gnome-disk-utility
      # TODO: COnfirm: ENabled with logitech.solaar, not needed?
      #solaar # Linux manager for many Logitech keyboards, mice
      # junction # default app selector
      kooha # Screen recorder for x11/Wayland
      # flameshot # Screen capture - currently has a bug
      satty # annotation
      colorpicker # colour picker
      ydotool # xdotool alternative. window automation
      tcpdump
      usbutils # usb utilities like lsusb
      pciutils # list all PCI devic
      steam-run # helps run some static compiled binaries
      file
      killall # kill all instances of a running app
      dex # open desktop files from the terminal
      textsnatcher # copy text from images
      pup # Terminal HTML parser
      # ncdu # disk usage analyzer - replaced with gdu
      tesseract # CLI OCR
      gping # visual ping alternative
      dysk # Mounted Disk Info
      appimage-run # Run AppImages
      glow # Render Markdown on the CLI
      gnupg # encryption and signing tool
      lshw # hardware lister
      sshfs # filesystem client over SSH
      openssl # cryptographic toolkit
      # ntfy # shell notification tool
      bottom # system monitoring tool
      procs # ps alternative
      desktop-file-utils # utilities for working with desktop files
      du-dust # disk usage utility
      gdu # disk usage analyzer
      dua # disk usage analyzer
      duf # disk usage/free utility
      dufs # static file server
      inetutils # network utilities
      dogdns # dig alternative
      xorg.xkill # kill client by X resource
      imagemagick_light # image manipulation library
      coreutils # basic file, shell, and text manipulation
      wget # file download utility
      xclip # command line interface to X clipboard
      ripgrep # grep alternative
      ffmpeg_6-full # multimedia processing
      v4l-utils # camera controls
      libthai # Needed for some appImages
      libnotify # notification library
      # lftp # file transfer program
      unzip # file decompression tool
    ];
    programs.wshowkeys.enable = true;

    home-manager.users."${user-settings.user.username}" = {
      programs = { btop = { enable = true; }; };
    };
  };
}
