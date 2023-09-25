{ config, pkgs, ... }:

{
  services.syncthing.settings.gui = {
    user = "dustin";
    password = "st-is-awesome-57!";
  };
}
