{ config, pkgs, ... }: {
  boot = {
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
    kernelModules = [
      "v4l2loopback"
      # Virtual Microphone, built-in
      "snd-aloop"
    ];
    # Set initial kernel module settings
    extraModprobeConfig = ''
      # exclusive_caps: Skype, Zoom, Teams etc. will only show device when actually streaming
      # card_label: Name of virtual camera, how it'll show up in Skype, Zoom, Teams
      # https://github.com/umlaeute/v4l2loopback
      options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
    '';
  };
  # libimobiledevice - iphone
  # v4k-utils - obs
  environment.systemPackages = with pkgs; [ v4l-utils libimobiledevice ];

  # Droidcam USB to Iphone
  services.usbmuxd = {
    package = pkgs.usbmuxd2;
    enable = true;
  };
}
