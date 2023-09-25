{ config, pkgs, ... }:

{
  imports = [ ./common.nix ];
  services.syncthing = {
    # Sets the Config Directory (important because I sync it as a part of my .config files)
    # Note: if you don’t persist the configDir, the device ID will change after each nixos-rebuild switch.
    # ToDo - add a host variable, then add to sync
    configDir = "/home/dustin/.config/syncthing/dustin-krysak";

    # Declaring the devices - no automated way to grab the device ID’s.
    # Hop into the web interface of each device and go to Settings -> Show ID,
    # then copy and paste it into my config.

    settings = {
      # NOTE - these are the devices you are sharing with, not the device you are on
      devices = {
        "rembot" = {
          # tailscale only
          addresses = [ "tcp://100.89.186.70:22000" ];
          id =
            "ZHSE4N7-IBYDJLI-XZE7VSC-RE7LMKE-JYVTAPT-XIEGEQ4-I64EPDE-AJQRNAJ";
        };
        "nixdo" = {
          # tailscale only
          addresses = [ "tcp://100.69.151.20:22000" ];
          id =
            "JYB4EDF-33276IS-BTPYWQ2-7E4P3NY-JW4JJLF-QOCCE3A-W6DWJ7H-6CI3AQU ";
        };
      };
      folders = {
        "Desktop" = {
          path = "/home/dustin/Desktop";
          devices = [ "nixdo" "rembot" ];
          # keep just a handful of old versions of the config files. This ensures that I’m not eating up a ton of disk space, while giving me the ability to roll back far enough to resolve issues I create for myself.
          versioning = {
            type = "simple";
            params = { keep = "10"; };
          };
        };
        "Documents" = {
          path = "/home/dustin/Documents";
          devices = [ "nixdo" "rembot" ];

          #  The gist of staggered versioning is Syncthing will keep new versions created with an RPO of down to 30 seconds for the first hour, hourly versions for the first day, daily versions for the first month, and weekly versions until the maxAge is reached.

          # I set the cleanInterval parameter to hourly, meaning each hour it will purge old versions that have aged out. Then finally I configure the maxAge to 90 days calculated in seconds.
          versioning = {
            type = "staggered";
            params = {
              cleanInterval = "3600";
              maxAge = "7776000"; # 90 days
            };
          };
        };
        "Downloads" = {
          path = "/home/dustin/Downloads";
          devices = [ "nixdo" "rembot" ];
          versioning = {
            type = "simple";
            params = { keep = "10"; };
          };
        };
        "Music" = {
          path = "/home/dustin/Music";
          devices = [ "nixdo" "rembot" ];
          versioning = {
            type = "simple";
            params = { keep = "10"; };
          };
        };
        "Pictures" = {
          path = "/home/dustin/Pictures";
          devices = [ "nixdo" "rembot" ];
          versioning = {
            type = "simple";
            params = { keep = "10"; };
          };
        };
        "Videos" = {
          path = "/home/dustin/Videos";
          devices = [ "nixdo" "rembot" ];
          versioning = {
            type = "simple";
            params = { keep = "10"; };
          };
        };
        "dev" = {
          path = "/home/dustin/dev";
          devices = [ "nixdo" "rembot" ];
          versioning = {
            type = "staggered";
            params = {
              cleanInterval = "3600";
              maxAge = "7776000"; # 90 days
            };
          };
        };
        ".gnupg" = {
          path = "/home/dustin/.gnupg";
          devices = [ "nixdo" "rembot" ];
          ignorePerms =
            false; # By default, Syncthing doesn't sync file permissions. This line enables it for this folder.
          versioning = {
            type = "staggered";
            params = {
              cleanInterval = "3600";
              maxAge = "7776000"; # 90 days
            };
          };
        };
        ".aws" = {
          path = "/home/dustin/.aws";
          devices = [ "nixdo" "rembot" ];
          versioning = {
            type = "staggered";
            params = {
              cleanInterval = "3600";
              maxAge = "7776000"; # 90 days
            };
          };
        };
        ".kube" = {
          path = "/home/dustin/.kube";
          devices = [ "nixdo" "rembot" ];
          versioning = {
            type = "staggered";
            params = {
              cleanInterval = "3600";
              maxAge = "7776000"; # 90 days
            };
          };
        };
        ".doppler" = {
          path = "/home/dustin/.doppler";
          devices = [ "nixdo" "rembot" ];
          versioning = {
            type = "staggered";
            params = {
              cleanInterval = "3600";
              maxAge = "7776000"; # 90 days
            };
          };
        };
        "virter" = {
          path = "/home/dustin/.config/virter";
          devices = [ "nixdo" "rembot" ];
          versioning = {
            type = "staggered";
            params = {
              cleanInterval = "3600";
              maxAge = "7776000"; # 90 days
            };
          };
        };
        "bin" = {
          path = "/home/dustin/bin";
          devices = [ "nixdo" "rembot" ];
          versioning = {
            type = "staggered";
            params = {
              cleanInterval = "3600";
              maxAge = "7776000"; # 90 days
            };
          };
        };

      };
    };
  };
}
