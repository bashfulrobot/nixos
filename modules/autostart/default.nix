# ~/.config/autostart
{ ... }:
let
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {
  home-manager.users."${username}" = {
    home.file."1password.desktop" = {
      source = ../desktop-files/src/1password.desktop;
      target = ".config/autostart/1password.desktop";
    };
  };
}
