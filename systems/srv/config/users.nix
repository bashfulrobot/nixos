{ config, pkgs, ... }: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dustin = {
    isNormalUser = true;
    description = "dustin";
    extraGroups = [ "docker" "wheel" ];
    shell = "/run/current-system/sw/bin/fish";
  };

}
