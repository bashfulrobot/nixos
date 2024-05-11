{ pkgs, config, lib, inputs, ... }:
let
  cfg = config.apps.nautilus;
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";

in {
  options = {
    apps.nautilus.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable nautilus.";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users."${username}" = {
      home.packages = with pkgs;
        [
          gnome.nautilus # file manager
        ];

      dconf.settings = with inputs.home-manager.lib.hm.gvariant; {

        "org/gnome/nautilus/list-view" = { use-tree-view = true; };

        "org/gnome/nautilus/preferences" = {
          default-folder-viewer = "icon-view";
          migrated-gtk-settings = true;
          search-filter-time-type = "last_modified";
          search-view = "list-view";
          show-create-link = true;
        };

      };
    };
  };
}
