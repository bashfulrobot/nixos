{ config, lib, ... }:

with lib.hm.gvariant;

{

  dconf.settings = {

    "org/gnome/shell/extensions/GPU_profile_selector" = {
      rtd3 = true;
      force-composition-pipeline = true;
      coolbits = true;
      force-topbar-view = false;
    };
  };

}
