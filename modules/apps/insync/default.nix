{ user-settings, lib, inputs, pkgs, config, ... }:
let cfg = config.apps.insync;

in {
  options = {
    apps.insync.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable gdrive sync.";
    };

  };

  config = lib.mkIf cfg.enable {

    # use regular package
    environment.systemPackages = with pkgs; [
      insync
      insync-nautilus
      insync-emblem-icons
    ];

    systemd.user.services.insync = {
      Unit = {
        Description =
          "Insync - Google Drive, OneDrive, and Dropbox Syncing on Linux, Windows & Mac";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Install = { WantedBy = [ "graphical-session.target" ]; };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.insync}/bin/insync start --no-daemon";
        ExecStop = "${pkgs.insync}/bin/insync stop";
        Restart = "always";
        RestartSec = "5";
      };
    };

    home-manager.users."${user-settings.user.username}" = {

    };
  };
}
