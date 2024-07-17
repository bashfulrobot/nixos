{ pkgs, config, lib, ... }:
let cfg = config.hw.audio;
in {

  options = {
    hw.audio.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable centralised hosts file.";
    };
  };

  config = lib.mkIf cfg.enable {
    # Enable sound with pipewire.
    # The option definition `sound' no longer has any effect; please remove it.
    #The option was heavily overloaded and can be removed from most configurations.
    #sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    environment.systemPackages = with pkgs;
      [

      ];
  };
}
# sudo alsactl store - fixes  error: failed to import hw:0 use case configuration -2
