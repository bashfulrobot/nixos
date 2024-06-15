{ user-settings, secrets, config, pkgs, lib, ... }:

let
  cfg = config.cli.rclone;

  mountPath = "${user-settings.user.home}/Gdrive";
  mountSource = "gdrive:";
  cacheDir = "${user-settings.user.home}/.cache/rclone-gdrive";
  configPath = "${user-settings.user.home}/.config/rclone/rclone.conf";
  rcloneConfigData = ''
    [gdrive]
    type = drive
    client_id = ${secrets.rclone.clientId}
    client_secret = ${secrets.rclone.clientSecret}
    scope = drive
    token = {"access_token":"${secrets.rclone.accessToken}","token_type":"Bearer","refresh_token":"${secrets.rclone.refreshToken}","expiry":"${secrets.rclone.expiry}"}
    team_drive =
  '';
  rcloneConf = pkgs.writeText "rclone.conf" rcloneConfigData;
in {
  options = {
    cli.rclone.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable rclone.";
    };
  };

  config = lib.mkIf cfg.enable {

    security.wrappers = {
      fusermount = {
        source = "${pkgs.fuse}/bin/fusermount";
        setuid = true;
        setgid = false;
      };
    };

    environment = {

      systemPackages = with pkgs; [ rclone rclone-browser syncrclone ];

      etc."fuse.conf".text = ''
        user_allow_other
      '';

    };

    systemd = {
      services = {

        # Create the required folders - ran once.
        rclone-init = {
          script = ''
            /run/current-system/sw/bin/cp ${rcloneConf} ${configPath}
            /run/current-system/sw/bin/chmod 770 ${configPath}
            /run/current-system/sw/bin/mkdir -p ${mountPath} ${cacheDir}
            /run/current-system/sw/bin/chown "${user-settings.user.username}":root ${mountPath} ${cacheDir}
          '';
          serviceConfig = { Type = "oneshot"; };
          after = [ "network.target" ];
          wantedBy = [ "multi-user.target" ];
        };

        rclone-mount = {
          description = "rclone google drive mount";
          after = [ "rclone-init.service" ];
          serviceConfig = {
            Type = "notify";
            # User = "gnzh";
            # Group = "gnzh";
            ExecStart = ''
              /run/current-system/sw/bin/rclone \
               mount \
                --allow-other \
                --vfs-cache-mode full \
                --cache-dir ${cacheDir} \
                --no-modtime \
                --config ${configPath} \
                ${mountSource} \
                ${mountPath}
            '';
            ExecStop =
              "${config.security.wrapperDir}/fusermount -u ${mountPath}";
            Restart = "always";
            RestartSec = 10;
          };
          path = [ pkgs.rclone pkgs.fuse config.security.wrapperDir ];
          wantedBy = [ "multi-user.target" ];
        };

        rclone-init.enable = true;
        rclone-mount.enable = true;
      };

    };
  };
}
