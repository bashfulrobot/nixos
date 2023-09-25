{ config, pkgs, ... }:
{
  # {imported to configuration.nix direct as home-manager does not support 1password
  programs._1password = { enable = true; };

  # Enable the 1Passsword GUI with myself as an authorized user for polkit
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "dustin" ];
  };
}
