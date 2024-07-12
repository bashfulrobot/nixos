{ user-settings, pkgs, config, lib, inputs, ... }:
let
  cfg = config.desktops.addons.i3status-rust;
  # Used in my home manager code at the bottom of the file.

in {
  options = {
    desktops.addons.i3status-rust.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable i3status rust bar";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [

      ];

    home-manager.users."${user-settings.user.username}" = {

      programs.i3status-rust = {
        enable = true;
        bars = {
          top = {
            icons = "awesome6";
            # theme = "native";
            theme = "ctp-macchiato";
            blocks = [
              {
                block = "sound";
                driver = "pulseaudio";
                format = " $icon $output_name {$volume.eng(w:2) |}";
                click = [{
                  button = "right";
                  cnd = "pauvcontrol --tab=3";
                }];
                # mappings = {
                #   "alsa_output.pci-0000_00_1f.3.analog-stereo" = "";
                #   "bluez_sink.70_26_05_DA_27_A4.a2dp_sink" = "";
                # };
              }
              {
                block = "networkmanager";
                primary_only = true;
              }
              {
                block = "backlight";
                device = "intel_backlight";
              }
              {
                block = "battery";
                interval = 10;
                good = 60;
                warning = 20;
                critical = 10;
                format = "{percentage}";
              }
              {
                type = "time";
                format = " $timestamp.datetime(f:'%a %d/%m %R') ";
                interval = 1;
                timezone = "America/Vancouver";
              }
            ];
          };
        };
      };

    };
  };
}
