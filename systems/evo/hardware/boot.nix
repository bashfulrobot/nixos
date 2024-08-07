{ config, pkgs, ... }: {

  # Bootloader.
  boot.loader.systemd-boot = {
    enable = true;
    consoleMode = "max"; # ensure windows will be found in boot menu
    netbootxyz.enable = false;
    # Maximum number of latest generations in the boot menu. Useful to prevent boot partition running out of disk space.
    configurationLimit = 5;
  };

  boot.loader.efi.canTouchEfiVariables = true;
}