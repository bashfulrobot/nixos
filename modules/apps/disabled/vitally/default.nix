# https://github.com/TLATER/dotfiles/blob/7ce77190696375aab3543f7365d298729a548df5/home-config/config/graphical-applications/discord.nix
{ config, ... }:
let
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {
  home-manager.users."${username}" = {
    programs.firefox.webapps.vitally = {
      url =
        "https://sysdig.vitally.io/hubs/553ec776-875e-4a0e-a096-a3da3a0b6ea1/8acc40cb-e3ea-4da8-9570-4be27a10fff6";
      id = 0;

      extraSettings = config.programs.firefox.profiles."${username}".settings;
      backgroundColor = "#202225";

      comment = "Customer Success Dashboard.";
      genericName = "Vitally";
      categories = [ "Office" "Web" ];
    };
  };
}
