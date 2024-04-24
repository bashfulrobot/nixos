{ pkgs, secrets, ... }:
let
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {

     # Enable teamviewer
  services.teamviewer.enable = true;

  home-manager.users."${username}" = {

    home.packages = with pkgs;
      [
        teamviewer # remote support
      ];

  };
}
