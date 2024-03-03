{ config, lib, ... }:

with lib.hm.gvariant;

{

  dconf.settings = {
    # Gnome Extention - GPU Profile Selector
    "org/gnome/shell/extensions/GPU_profile_selector" = {
      rtd3 = true;
      force-composition-pipeline = true;
      coolbits = true;
      force-topbar-view = false;
    };

    #  Set Media Keys
    "org/gnome/settings-daemon/plugins/media-keys" = {
      play = [ "AudioPlay" ];
      volume-down = [ "AudioLowerVolume" ];
      volume-mute = [ "AudioMute" ];
      volume-up = [ "AudioRaiseVolume" ];
    };
  };

}
