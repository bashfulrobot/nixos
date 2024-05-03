{ pkgs, inputs, ... }:
let
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {
  home-manager.users."${username}" = {
    home.file."reboot-windows.desktop" = {
      source = ../src/reboot-windows.desktop;
      target = ".local/share/applications/reboot-windows.desktop";
    };

    home.file."reboot-firmware.desktop" = {
      source = ../src/reboot-firmware.desktop;
      target = ".local/share/applications/reboot-firmware.desktop";
    };

    home.file."seabird.desktop" = {
      source = ../src/seabird.desktop;
      target = ".local/share/applications/seabird.desktop";
    };

    home.file."monokle.desktop" = {
      source = ../src/monokle.desktop;
      target = ".local/share/applications/monokle.desktop";
    };

    home.file."warp.desktop" = {
      source = ../src/warp.desktop;
      target = ".local/share/applications/warp.desktop";
    };

    home.file."beeper.desktop" = {
      source = ../src/beeper.desktop;
      target = ".local/share/applications/beeper.desktop";
    };

    home.file."spacedrive.desktop" = {
      source = ../src/spacedrive.desktop;
      target = ".local/share/applications/spacedrive.desktop";
    };

    # home.file."ncspot.desktop" = {
    #   source = ../src/ncspot.desktop;
    #   target = ".local/share/applications/ncspot.desktop";
    # };

    home.file."cursor.desktop" = {
      source = ../src/cursor.desktop;
      target = ".local/share/applications/cursor.desktop";
    };

    # home.file."reboot.desktop" = {
    #   source = ../src/reboot.desktop;
    #   target = ".local/share/applications/reboot.desktop";
    # };

    # home.file."shutdown.desktop" = {
    #   source = ../src/shutdown.desktop;
    #   target = ".local/share/applications/shutdown.desktop";
    # };

    # home.file."suspend.desktop" = {
    #   source = ../src/suspend.desktop;
    #   target = ".local/share/applications/suspend.desktop";
    # };
  };
}
