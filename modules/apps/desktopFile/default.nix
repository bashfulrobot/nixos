{ user-settings, pkgs, config, lib, inputs, ... }:
let
  cfg = config.apps.desktopFile;

in {
  options = {
    apps.desktopFile.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable desktopFile";
    };
    apps.desktopFile.reboot-firmware = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable reboot-firmware.desktop";
    };
    apps.desktopFile.warp = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable warp.desktop";
    };
    apps.desktopFile.seabird = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable seabird.desktop";
    };
    apps.desktopFile.beeper = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable beeper.desktop";
    };
    apps.desktopFile.monokle = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable monokle.desktop";
    };
    apps.desktopFile.cursor = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable cursor.desktop";
    };
    apps.desktopFile.spacedrive = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable spacedrive.desktop";
    };
    apps.desktopFile._1password = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable 1password.desktop";
    };
    apps.desktopFile.ncspot = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable ncspot.desktop";
    };
    apps.desktopFile.spotify = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable spotify.desktop";
    };
    apps.desktopFile.suspend = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable suspend.desktop";
    };
    apps.desktopFile.solaar = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable solaar.desktop";
    };
    apps.desktopFile.shutdown = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable shutdown.desktop";
    };
    apps.desktopFile.reboot-tailscale = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable reboot-tailscale.desktop";
    };
    apps.desktopFile.reboot = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable reboot.desktop";
    };
    apps.desktopFile.reboot-windows = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable reboot-windows.desktop";
    };
    apps.desktopFile.gitbutler = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable gitbutler.desktop";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users."${user-settings.user.username}" = {
      home.file."reboot-firmware.desktop" = lib.mkIf cfg.reboot-firmware {
        source = ./src/reboot-firmware.desktop;
        target = ".local/share/applications/reboot-firmware.desktop";
      };
      home.file."warp.desktop" = lib.mkIf cfg.warp {
        source = ./src/warp.desktop;
        target = ".local/share/applications/warp.desktop";
      };
      home.file."seabird.desktop" = lib.mkIf cfg.seabird {
        source = ./src/seabird.desktop;
        target = ".local/share/applications/seabird.desktop";
      };
      home.file."beeper.desktop" = lib.mkIf cfg.beeper {
        source = ./src/beeper.desktop;
        target = ".local/share/applications/beeper.desktop";
      };
      home.file."gitbutler.desktop" = lib.mkIf cfg.gitbutler {
        source = ./src/gitbutler.desktop;
        target = ".local/share/applications/gitbutler.desktop";
      };
      home.file."monokle.desktop" = lib.mkIf cfg.monokle {
        source = ./src/monokle.desktop;
        target = ".local/share/applications/monokle.desktop";
      };
      home.file."cursor.desktop" = lib.mkIf cfg.cursor {
        source = ./src/cursor.desktop;
        target = ".local/share/applications/cursor.desktop";
      };
      home.file."spacedrive.desktop" = lib.mkIf cfg.spacedrive {
        source = ./src/spacedrive.desktop;
        target = ".local/share/applications/spacedrive.desktop";
      };
      home.file."1password.desktop" = lib.mkIf cfg._1password {
        source = ./src/1password.desktop;
        target = ".local/share/applications/1password.desktop";
      };
      home.file."ncspot.desktop" = lib.mkIf cfg.ncspot {
        source = ./src/ncspot.desktop;
        target = ".local/share/applications/ncspot.desktop";
      };
      home.file."spotify.desktop" = lib.mkIf cfg.spotify {
        source = ./src/spotify.desktop;
        target = ".local/share/applications/spotify.desktop";
      };
      home.file."suspend.desktop" = lib.mkIf cfg.suspend {
        source = ./src/suspend.desktop;
        target = ".local/share/applications/suspend.desktop";
      };
       home.file."solaar.desktop" = lib.mkIf cfg.solaar {
        source = ./src/solaar.desktop;
        target = ".local/share/applications/solaar.desktop";
      };
      home.file."shutdown.desktop" = lib.mkIf cfg.shutdown {
        source = ./src/shutdown.desktop;
        target = ".local/share/applications/shutdown.desktop";
      };
      home.file."reboot-tailscale.desktop" = lib.mkIf cfg.reboot-tailscale {
        source = ./src/reboot-tailscale.desktop;
        target = ".local/share/applications/reboot-tailscale.desktop";
      };
      home.file."reboot.desktop" = lib.mkIf cfg.reboot {
        source = ./src/reboot.desktop;
        target = ".local/share/applications/reboot.desktop";
      };
      home.file."reboot-windows.desktop" = lib.mkIf cfg.reboot-windows {
        source = ./src/reboot-windows.desktop;
        target = ".local/share/applications/reboot-windows.desktop";
      };
    };
  };
}
