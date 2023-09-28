{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {

    "org/gnome/nautilus/list-view" = { use-tree-view = true; };

    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "icon-view";
      migrated-gtk-settings = true;
      search-filter-time-type = "last_modified";
      search-view = "list-view";
      show-create-link = true;
    };

  };
}
