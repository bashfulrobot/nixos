{ pkgs, ... }: {
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
      # allowedBridges = "virbr0";
      onBoot = "start";
      onShutdown = "suspend";
    };
    # virtualbox.host = {
    #   enable = true;
    #   enableExtensionPack = true;
    # };
    # lxd = {
    # enable = true;
    # ui = {
    #   enable = true;
    #   package = pkgs.unstable.lxd-unwrapped.ui;
    # };
    # };
    multipass = {
      enable = true;
      # logLevel = "trace";
    };
  };

}
