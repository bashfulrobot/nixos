{ config, pkgs, secrets, ... }:

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
    dataDir = "${user-settings.user.home}";
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
    configDir = "${user-settings.user.home}/.config/syncthing/srv";

    # Declaring the devices - no automated way to grab the device ID’s.
    # Hop into the web interface of each device and go to Settings -> Show ID,
    # then copy and paste it into my config.

    settings = {
      extraOptions.gui = {
        user = "${secrets.syncthing.user}";
        password = "${secrets.syncthing.password}";
      };
      # NOTE - these are the devices you are sharing with, not the device you are on
      devices = {
        "rembot" = {
          # tailscale only
          addresses = [ "tcp://100.89.186.70:22000" ];
          id =
            "ZHSE4N7-IBYDJLI-XZE7VSC-RE7LMKE-JYVTAPT-XIEGEQ4-I64EPDE-AJQRNAJ";
        };
        "evo" = {
          # tailscale only
          addresses = [ "tcp://100.67.177.44:22000" ];
          id =
            "2742LWN-YCAKICC-MS2PPBE-LXGLB57-Z3SXBKB-K57Y5X7-IO6PFMO-RJOKNQZ";
        };
      };
      folders = {
        "srv-docs" = {
          path = "${user-settings.user.home}/Srv-docs";
          devices = [ "rembot" "evo" ];
          ignorePerms =
            false; # By default, Syncthing doesn't sync file permissions. This line enables it for this folder.

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
        ".gnupg" = {
          path = "${user-settings.user.home}/.gnupg";
          devices = [ "rembot" "evo" ];
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
        ".kube" = {
          path = "${user-settings.user.home}/.kube";
          devices = [ "rembot" "evo" ];
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
