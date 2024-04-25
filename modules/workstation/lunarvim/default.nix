{ pkgs, ... }:
let
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {

  environment.systemPackages = with pkgs;
    [
      lunarvim # opinionated neovim
    ];

  home-manager.users."${username}" = {
    home = {

      sessionVariables = { EDITOR = "lvim"; };

      file."config.lua" = {
        source = ./config/config.lua;
        target = ".config/lvim/config.lua";
      };

    };
  };

}
