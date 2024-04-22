{ pkgs, ... }:

let
  kubitect = pkgs.callPackage ./build { };

  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {
  home-manager.users."${username}" = {
    home.packages = with pkgs; [
      kubitect
      # dependencies
      virtualenv
      # git - installed globally
      # python - installed globally
    ];
  };
}
