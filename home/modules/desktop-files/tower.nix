{ config, lib, ... }:

{

  home.file."reboot-windows.desktop" = {
    source = ./reboot-windows.desktop;
    target = ".local/share/applications/reboot-windows.desktop";
  };

  home.file."reboot-firmware.desktop" = {
    source = ./reboot-firmware.desktop;
    target = ".local/share/applications/reboot-firmware.desktop";
  };

  home.file."monokle.desktop" = {
    source = ./monokle.desktop;
    target = ".local/share/applications/monokle.desktop";
  };

  home.file."beeper.desktop" = {
    source = ./beeper.desktop;
    target = ".local/share/applications/beeper.desktop";
  };

  # home.file."todoist.desktop" = {
  #   source = ./todoist.desktop;
  #   target = ".local/share/applications/todoist.desktop";
  # };

  home.file."spacedrive.desktop" = {
    source = ./spacedrive.desktop;
    target = ".local/share/applications/spacedrive.desktop";
  };

  # home.file."ncspot.desktop" = {
  #   source = ./ncspot.desktop;
  #   target = ".local/share/applications/ncspot.desktop";
  # };

  home.file."cursor.desktop" = {
    source = ./cursor.desktop;
    target = ".local/share/applications/cursor.desktop";
  };

  # home.file."reboot.desktop" = {
  #   source = ./reboot.desktop;
  #   target = ".local/share/applications/reboot.desktop";
  # };

  # home.file."shutdown.desktop" = {
  #   source = ./shutdown.desktop;
  #   target = ".local/share/applications/shutdown.desktop";
  # };

  # home.file."suspend.desktop" = {
  #   source = ./suspend.desktop;
  #   target = ".local/share/applications/suspend.desktop";
  # };
}
