{ config, pkgs, ... }: {

  # Bootloader.
  boot.loader.systemd-boot = {
    enable = true;
    consoleMode = "max"; # ensure windows will be found in boot menu
    netbootxyz.enable = false;
  };


  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-36f37672-b575-4510-b29a-ef4552f1332e".device = "/dev/disk/by-uuid/36f37672-b575-4510-b29a-ef4552f1332e";
  
}
