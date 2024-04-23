{ pkgs, inputs, ... }:
let
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";

in {
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
}
