{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [ syncthing ];

  services.syncthing = {
    enable = true;
    systemService = true;
    # Sets the user that Syncthing runs as
    user = "dustin";
    # Sets the group that Syncthing runs as
    group = "users";
    # Sets the Data Directory (the default sync directory, but we won’t use this)
    dataDir = "/home/dustin";
    # Sets the Web Interface to listen on all interfaces (for machines that are headless, I set to 0.0.0.0, otherwise 127.0.0.1)
    # Todo - bind to tailscale IP
    guiAddress = "0.0.0.0:8384";
    # Opens the default ports (21027/tcp & 22000) - note this doesn’t include the web interface
    openDefaultPorts = true;
    # override the devices and folders that are configured in the web interface.
    overrideDevices = true;
    overrideFolders = true;

    # Sets the Config Directory (important because I sync it as a part of my .config files)
    # Note: if you don’t persist the configDir, the device ID will change after each nixos-rebuild switch.
    # ToDo - add a host variable, then add to sync
    configDir = "/home/dustin/.config/syncthing/nixdo";

    # Declaring the devices - no automated way to grab the device ID’s.
    # Hop into the web interface of each device and go to Settings -> Show ID,
    # then copy and paste it into my config.

    settings = {
      extraOptions.gui = {
        user = "dustin";
        password = "st-is-awesome-57!";
      };
      # NOTE - these are the devices you are sharing with, not the device you are on
      devices = {
        "rembot" = {
          # tailscale only
          addresses = [ "tcp://100.89.186.70:22000" ];
          id =
            "ZHSE4N7-IBYDJLI-XZE7VSC-RE7LMKE-JYVTAPT-XIEGEQ4-I64EPDE-AJQRNAJ";
        };
        "dustin-krysak" = {
          addresses = [ "tcp://100.90.174.2:22000" ];
          id =
            "YIQDEHY-QM44YI5-4KP2ZJ5-3FEUIXF-5DVHZVV-VOSZGXH-QCZFLBJ-FKAK2AA";
        };
      };
      folders = {
        "Desktop" = {
          path = "/home/dustin/Desktop";
          devices = [ "rembot" "dustin-krysak" ];
          # keep just a handful of old versions of the config files. This ensures that I’m not eating up a ton of disk space, while giving me the ability to roll back far enough to resolve issues I create for myself.
          versioning = {
            type = "simple";
            params = { keep = "10"; };
          };
        };
        "Documents" = {
          path = "/home/dustin/Documents";
          devices = [ "rembot" "dustin-krysak" ];

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
          devices = [ "rembot" "dustin-krysak" ];
          versioning = {
            type = "simple";
            params = { keep = "10"; };
          };
        };
        "Music" = {
          path = "/home/dustin/Music";
          devices = [ "rembot" "dustin-krysak" ];
          versioning = {
            type = "simple";
            params = { keep = "10"; };
          };
        };
        "Pictures" = {
          path = "/home/dustin/Pictures";
          devices = [ "rembot" "dustin-krysak" ];
          versioning = {
            type = "simple";
            params = { keep = "10"; };
          };
        };
        "Videos" = {
          path = "/home/dustin/Videos";
          devices = [ "rembot" "dustin-krysak" ];
          versioning = {
            type = "simple";
            params = { keep = "10"; };
          };
        };
        "dev" = {
          path = "/home/dustin/dev";
          devices = [ "rembot" "dustin-krysak" ];
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
          devices = [ "rembot" "dustin-krysak" ];
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
          devices = [ "rembot" "dustin-krysak" ];
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
          devices = [ "rembot" "dustin-krysak" ];
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
          devices = [ "rembot" "dustin-krysak" ];
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
          devices = [ "rembot" "dustin-krysak" ];
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
          devices = [ "rembot" "dustin-krysak" ];
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
          devices = [ "rembot" ];
          versioning = {
            type = "simple";
            params = { keep = "10"; };
          };
        };

      };
    };
  };
}
