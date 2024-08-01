{ config, pkgs, ... }: {

  # Bootloader.
  boot.loader.systemd-boot = {
    enable = true;
    consoleMode = "max"; # ensure windows will be found in boot menu
    netbootxyz.enable = false;
  };


  boot.loader.efi.canTouchEfiVariables = true;
  
}
