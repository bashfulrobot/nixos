{ pkgs, ... }:

let
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {
  home-manager.users."${username}" = {
    # Getting yaru cursor, sound and icon themes
    home.packages = with pkgs; [
      nordic
      nordzy-icon-theme
      nordzy-cursor-theme
      papirus-nord
    ];

  };
  # App / Desktop themes
    imports = [ ./apps/gitnauro.nix ./apps/alacritty.nix ./settings ];
}
