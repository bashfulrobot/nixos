{ user-settings, pkgs, config, lib, ... }:
let cfg = config.sys.xdg;
in {

  options = {
    sys.xdg.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable xdg.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ xdg-utils ];
    # Enable xdg
    xdg = {
      mime.enable = true;
      autostart.enable = true;
      icons.enable = true;
      menus.enable = true;
      sounds.enable = true;
    };

    home-manager.users."${user-settings.user.username}" = {
      xdg = {
        # TODO: remeber, forcing the file to be overwritten when home-manager is run
        configFile."mimeapps.list".force = true;

        # desktopEntries.librewolf = {
        #   name = "LibreWolf";
        #   exec = "${pkgs.librewolf}/bin/librewolf";
        # };
        mimeApps = {
          associations = {
            # added = { "x-scheme-handler/tg" = "org.telegram.desktop.desktop"; };
          };
          enable = true;
          defaultApplications = {
            "text/html" = [ "com.github.cassidyjames.ephemeral.desktop" ];
            "text/plain" = [ "code.desktop" ];
            # "inode/directory" = [ "lf.desktop" ];
            # "application/pdf" = [ "okular.desktop" ];
            "applications/x-www-browser" = [ "com.github.cassidyjames.ephemeral.desktop" ];
            "x-scheme-handler/about" = [ "com.github.cassidyjames.ephemeral.desktop" ];
            "x-scheme-handler/http" = [ "com.github.cassidyjames.ephemeral.desktop" ];
            "x-scheme-handler/https" = [ "com.github.cassidyjames.ephemeral.desktop" ];
            "x-scheme-handler/mailto" = [ "com.github.cassidyjames.ephemeral.desktop" ];
            "x-scheme-handler/msteams" = [ "teams-for-linux.desktop" ];
            "x-scheme-handler/postman" = [ "Postman.desktop" ];
            "x-scheme-handler/unknown" = [ "com.github.cassidyjames.ephemeral.desktop" ];
            "x-scheme-handler/slack" = [ "slack.desktop" ];
            # "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
            "x-scheme-handler/webcal" = [ "com.github.cassidyjames.ephemeral.desktop" ];
          };
        };
      };
    };
  };
}
