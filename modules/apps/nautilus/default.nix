{ user-settings, pkgs, config, lib, inputs, ... }:
let
  cfg = config.apps.nautilus;

in {
  options = {
    apps.nautilus.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable nautilus.";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users."${user-settings.user.username}" = {
      home.packages = with pkgs;
        [
          nautilus # file manager
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
