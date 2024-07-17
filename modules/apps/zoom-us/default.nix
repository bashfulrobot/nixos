{ user-settings, pkgs, config, lib, ... }:
let
  cfg = config.apps.zoom-us;

in {
  options = {
    apps.zoom-us.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the zoom-us desktop.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      zoom-us # video conferencing - broken currently
    ];
    home-manager.users."${user-settings.user.username}" = {

      # force zoom to use wayland and portals
      home.file.".config/zoomus.conf".text = ''
        xwayland=false
      '';
    };
  };
}
