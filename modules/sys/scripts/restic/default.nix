{ pkgs, config, lib, ... }:
let
  cfg = config.sys.scripts.restic;
  resticPruneNextstar = ''
        #!/usr/bin/env bash

    /run/current-system/sw/bin/restic --password-command '/usr/bin/pass automation/restic-nexstar' -r /media/dustin/EXTERNAL/backups/desktop/ forget --prune --keep-daily 14 --keep-weekly 5 --keep-monthly 12 --keep-yearly 75 && RESULT="$(/run/current-system/sw/bin/restic --password-command '/usr/bin/pass automation/restic-nexstar' -r /media/dustin/EXTERNAL/backups/desktop/ check)"

    telegram-send "$RESULT"

    exit 0
  '';

  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {
  options = {
    sys.scripts.restic.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the restic scripts.";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users."${username}" = {
      home.packages = with pkgs;
        [
          (writeScriptBin "restic-prune-nexstar.sh" resticPruneNextstar)

        ];
    };
  };
}