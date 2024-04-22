{ config, pkgs, ... }: {

  # Bootloader.
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max"; # ensure windows will be found in boot menu
        netbootxyz.enable = false;
      };
      efi.canTouchEfiVariables = true;
    };
    kernel = {
      sysctl = {
        # Enable traffic between interfaces
        "net.ipv4.conf.all.forwarding" = true;
        "net.ipv6.conf.all.forwarding" = true;
      };
    };
  };

}
