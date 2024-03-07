{ pkgs, ... }: {

  # Install necessary packages
  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    win-virtio
    win-spice
  ];

  virtualisation = {
    docker.enable = true;
    # multipass.enable = true;
    # android container - sudo waydroid init (or sudo waydroid init -s GAPPS -f)
    # waydroid wiki - https://nixos.wiki/wiki/WayDroid
    # registering GAPPS - https://docs.waydro.id/faq/google-play-certification
    #waydroid.enable = true;
    # lxd is needed for Waydroid
    # lxd.enable = true;
    libvirtd = {
      enable = true;
      allowedBridges = [ "virbr0" "br0" ];
      onBoot = "start";
      onShutdown = "suspend";
      # https://github.com/tompreston/qemu-ovmf-swtpm
      # qemu = {
      #   swtpm.enable = true;
      #   ovmf.enable = true;
      #   ovmf.packages = [ pkgs.OVMFFull.fd ];
      # };
    };

    spiceUSBRedirection.enable = true;

  };
  services.spice-vdagentd.enable = true;

}
