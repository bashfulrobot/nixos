{ config, pkgs, secrets, ... }:

{
  services.syncthing.settings.gui = {
    user = "${secrets.syncthing.user}";
    password = "${secrets.syncthing.password}";
  };
}
