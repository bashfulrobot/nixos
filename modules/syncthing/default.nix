{ config, pkgs, secrets, ... }:
let
  hostname= builtins.getEnv "hostname";
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {
  imports = [ ./syncthing-gui-login.nix ./evo ];

  environment.systemPackages = with pkgs; [
    syncthing
    gnomeExtensions.syncthing-indicator
  ];

  # Syncthing ports
  # networking.firewall.allowedTCPPorts = [ 8384 22000 ];
  # networking.firewall.allowedUDPPorts = [ 22000 21027 ];

  services.syncthing = {
    enable = true;
    systemService = true;
    # Sets the user that Syncthing runs as
    user = "${username}";
    # Sets the group that Syncthing runs as
    group = "users";
    # Sets the Data Directory (the default sync directory, but we won’t use this)
    dataDir = "/home/${username}";
    # Sets the Web Interface to listen on all interfaces (for machines that are headless, I set to 0.0.0.0, otherwise 127.0.0.1)
    # Todo - bind to tailscale IP
    guiAddress = "0.0.0.0:8384";
    # Opens the default ports (21027/tcp & 22000) - note this doesn’t include the web interface
    openDefaultPorts = true;
    # override the devices and folders that are configured in the web interface.
    overrideDevices = true;
    overrideFolders = true;
  };
}
