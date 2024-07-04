{ pkgs, config, lib, user-settings, ... }:
let cfg = config.hw.bluetooth;
in {
  options = {
    hw.bluetooth.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable bluetooth.";
    };
    hw.bluetooth.logitech.solaar = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable logitech wireless for solaar.";
    };
    hw.bluetooth.airpods.join = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description =
        "Enable BR/EDR mode for AirPods connection. Disable after connection.";
    };
  };

  config = lib.mkIf cfg.enable {
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
    hardware.bluetooth = lib.trace "bluetooth Hardware module ran" {
      enable = true;
      powerOnBoot = true; # powers up the default Bluetooth controller on boot
      settings = {
        General = {
          MultiProfile = "multiple";
          Privacy = "device";
          FastConnectable = true;
          Enable = "Control,Gateway,Headset,Media,Sink,Socket,Source";
          ControllerMode = lib.mkIf cfg.airpods.join "bredr";
        };
      };
    };

    home-manager.users."${user-settings.user.username}" =
      lib.trace "bluetooth HM module ran" {
        # Some bluetooth headsets have buttons for pause/play or to skip to the next track. To make these buttons usable with media players supporting the dbus-based MPRIS standard,
        systemd.user.services.mpris-proxy = {
          description = "Mpris proxy";
          after = [ "network.target" "sound.target" ];
          wantedBy = [ "default.target" ];
          serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
        };
      };

    hardware.logitech.wireless = lib.mkIf cfg.airpods.join { enable = true; };
  };
}
