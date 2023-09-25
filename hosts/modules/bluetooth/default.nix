{ pkgs, config, ... }:

{

  environment.systemPackages = with pkgs; [
    bluez # Bluetooth stack
    blueman # Bluetooth Manager
  ];

  services.blueman.enable = true;

  # Needed for Keychron K2 - Need to confirm for airpods
  boot.extraModprobeConfig = ''
    options hid_apple fnmode=2
  '';
  boot.kernelModules = [ "hid-apple" ];

  # Enable Bluetooth
  # High quality BT calls
  hardware.bluetooth = {
    enable = true;
    # conflicts with Wireplumber
    # hsphfpd = { enable = true; };
    # Modern headsets will generally try to connect using the A2DP profile: Enabling A2DP Sink

    settings = {
      General = {
        MultiProfile = "multiple";
        Privacy = "device";
        FastConnectable = true;
        Enable = "Control,Gateway,Headset,Media,Sink,Socket,Source";
        # Uncomment this in the first time you want to connect to AirPods.
        # In order to connect, you have to press the button on the back
        # of the AirPods case.
        # `breder` is only needed for the initial connection of the AirPods.
        # Afterwards the mode can be relaxed to `dual` (the default) again.
        # ControllerMode = "bredr";
      };
    };
  };

  # used for solaar
  hardware.logitech.wireless.enable = true;
}
