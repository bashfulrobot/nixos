{ user-settings, pkgs, config, lib, inputs, system, ... }:
with lib;
let cfg = config.desktops.hyprland.config.wayland;
in {
  options.desktops.hyprland.config.wayland.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable hyprswitch for hyprland";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [

      ];

    home-manager.users.${user-settings.user.username} = {

      services = { clipman.enable = true; };

      systemd.user.services.polkit-gnome-authentication-agent-1 = {
        Unit.Description = "polkit-gnome-authentication-agent-1";
        Install.WantedBy = [ "graphical-session.target" ];
        Service = {
          Type = "simple";
          ExecStart =
            "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };

    };
  };
}
