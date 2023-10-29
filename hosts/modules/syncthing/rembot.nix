{ config, pkgs, ... }:

{
  imports = [ ./common.nix ];

  services.syncthing = {

    # Sets the Config Directory (important because I sync it as a part of my .config files)
    # Note: if you don’t persist the configDir, the device ID will change after each nixos-rebuild switch.
    # ToDo - add a host variable, then add to sync
    configDir = "/home/dustin/.config/syncthing/rembot";

    # Declaring the devices - no automated way to grab the device ID’s.
    # Hop into the web interface of each device and go to Settings -> Show ID,
    # then copy and paste it into my config.

    # NOTE - these are the devices you are sharing with, not the device you are on
    settings = {
      devices = {

        "dustin-krysak" = {
          addresses = [ "tcp://100.124.99.18:22000" ];
          id =
            "WZRTON7-M3U5XFL-5LEZR6P-NOA7CAO-S2VIUMU-25NXPX4-AQXHXGA-IBFO2QJ";
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
          devices = [ "nixdo" "dustin-krysak" ];
          # keep just a handful of old versions of the config files. This ensures that I’m not eating up a ton of disk space, while giving me the ability to roll back far enough to resolve issues I create for myself.
          versioning = {
            type = "simple";
            params = { keep = "10"; };
          };
        };
        "Documents" = {
          path = "/home/dustin/Documents";
          devices = [ "nixdo" "dustin-krysak" ];

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
          devices = [ "nixdo" "dustin-krysak" ];
          versioning = {
            type = "simple";
            params = { keep = "10"; };
          };
        };
        "Music" = {
          path = "/home/dustin/Music";
          devices = [ "nixdo" "dustin-krysak" ];
          versioning = {
            type = "simple";
            params = { keep = "10"; };
          };
        };
        "Pictures" = {
          path = "/home/dustin/Pictures";
          devices = [ "nixdo" "dustin-krysak" ];
          versioning = {
            type = "simple";
            params = { keep = "10"; };
          };
        };
        "Videos" = {
          path = "/home/dustin/Videos";
          devices = [ "nixdo" "dustin-krysak" ];
          versioning = {
            type = "simple";
            params = { keep = "10"; };
          };
        };
        "dev" = {
          path = "/home/dustin/dev";
          devices = [ "nixdo" "dustin-krysak" ];
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
          devices = [ "nixdo" "dustin-krysak" ];
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
          devices = [ "nixdo" "dustin-krysak" ];
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
          devices = [ "nixdo" "dustin-krysak" ];
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
          devices = [ "nixdo" "dustin-krysak" ];
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
          devices = [ "nixdo" "dustin-krysak" ];
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
          devices = [ "nixdo" "dustin-krysak" ];
          versioning = {
            type = "staggered";
            params = {
              cleanInterval = "3600";
              maxAge = "7776000"; # 90 days
            };
          };
        };
        "ms-edge" = {
          path = "/home/dustin/.config/microsoft-edge";
          devices = [ "nixdo" ];
          versioning = {
            type = "simple";
            params = { keep = "10"; };
          };
        };

      };
    };
  };
}
