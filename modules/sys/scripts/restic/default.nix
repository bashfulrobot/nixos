{ user-settings, pkgs, lib, config, ... }:

let
  cfg = config.sys.scripts.restic;
  resticPruneNextstar = pkgs.writeShellApplication {
    name = "restic-prune-nexstar";

    runtimeInputs = [ pkgs.restic pkgs.pass ];

    text = ''
      #!/run/current-system/sw/bin/env bash

      restic --password-command 'pass automation/restic-nexstar' -r /media/dustin/EXTERNAL/backups/desktop/ forget --prune --keep-daily 14 --keep-weekly 5 --keep-monthly 12 --keep-yearly 75 && RESULT="$(restic --password-command 'pass automation/restic-nexstar' -r /media/dustin/EXTERNAL/backups/desktop/ check)"

      # telegram-send "$RESULT"

      exit 0
    '';
  };
in {
  options = {
    sys.scripts.restic.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the restic script.";
    };
  };
  config = lib.mkIf cfg.enable {
    #   environment.systemPackages = [ resticPruneNextstar ];
    home-manager.users."${user-settings.user.username}" = {
      home.packages = with pkgs; [ resticPruneNextstar ];
    };
  };

}
