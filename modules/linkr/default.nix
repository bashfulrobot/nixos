{ pkgs, ... }:

let
  linkr = pkgs.callPackage ./build { };
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {
  home-manager.users."${username}" = {
    home.packages = with pkgs; [ linkr ];

    home.file."linkr.desktop" = {
      source = ./build/linkr.desktop;
      target = ".local/share/applications/linkr.desktop";
    };

    home.file."linkr-icon.png" = {
      source = ./build/linkr-icon.png;
      target = ".local/share/icons/hicolor/48x48/apps/linkr.png";
    };

    home.file."config.yaml" = {
      source = ./build/config.yaml;
      target = ".config/linkr/config.yaml";
    };
  };
}
