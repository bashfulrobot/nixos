{ config, lib, ... }:

{

  home.file."reboot-firmware.desktop" = {
    source = ./reboot-firmware.desktop;
    target = ".local/share/applications/reboot-firmware.desktop";
  };

  home.file."beeper.desktop" = {
    source = ./beeper.desktop;
    target = ".local/share/applications/beeper.desktop";
  };

  home.file."ncspot.desktop" = {
    source = ./ncspot.desktop;
    target = ".local/share/applications/ncspot.desktop";
  };

  home.file."cursor.desktop" = {
    source = ./cursor.desktop;
    target = ".local/share/applications/cursor.desktop";
  };
}
