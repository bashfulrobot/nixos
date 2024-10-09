# https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/
{ user-settings, pkgs, config, lib, ... }:
let cfg = config.desktops.hyprland.wofi;

in {
  options = {
    desktops.hyprland.wofi.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable wofi Launcher.";
    };
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = with pkgs;
      [

      ];

    home-manager.users."${user-settings.user.username}" = {
      programs.wofi = {
        enable = true;
        #style = { };
        settings = {
          image_size = 48;
          columns = 3;
          allow_images = true;
          insensitive = true;
          run-always_parse_args = true;
          run-cache_file = "/dev/null";
          run-exec_search = true;
          matching = "multi-contains";
        };
      };
    };
  };
}
