{ user-settings, pkgs, config, lib, inputs, ... }:
let
  cfg = config.desktops.addons.swayidle;
  swaylock = "${pkgs.swaylock}/bin/swaylock";
  pgrep = "${pkgs.procps}/bin/pgrep";
  pactl = "${pkgs.pulseaudio}/bin/pactl";
  swaymsg = "${pkgs.sway}/bin/swaymsg";
  my-wallpaper = "$HOME/Pictures/wallpapers/skullskates.png"; # TODO set global

  isLocked = "${pgrep} -x ${swaylock}";
  lockTime = 10 * 60; # TODO: configurable desktop (10 min)/laptop (4 min)

  # Makes two timeouts: one for when the screen is not locked (lockTime+timeout) and one for when it is.
  afterLockTimeout = { timeout, command, resumeCommand ? null, }: [
    {
      timeout = lockTime + timeout;
      inherit command resumeCommand;
    }
    {
      command = "${isLocked} && ${command}";
      inherit resumeCommand timeout;
    }
  ];
in {
  options = {
    desktops.addons.swayidle.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable swayidle";
    };
  };
  config = lib.mkIf cfg.enable {
    home-manager.users."${user-settings.user.username}" = {
      services.swayidle = {
        enable = true;
        systemdTarget = "graphical-session.target";
        timeouts =
          # Lock screen
          [{
            timeout = lockTime;
            command = "${swaylock} -i ${user-settings.user.wallpaper} --daemonize";
          }] ++
          # Mute mic
          (afterLockTimeout {
            timeout = 10;
            command = "${pactl} set-source-mute @DEFAULT_SOURCE@ yes";
            resumeCommand = "${pactl} set-source-mute @DEFAULT_SOURCE@ no";
          }) ++
          # # Turn off RGB
          # afterLockTimeout {
          #   timeout = 20;
          #   command = "systemctl --user stop rgbdaemon";
          #   resumeCommand = "systemctl --user start rgbdaemon";
          # }
          # Turn off displays (sway)
          afterLockTimeout {
            timeout = 40;
            command = "${swaymsg} 'output * dpms off'";
            resumeCommand = "${swaymsg} 'output * dpms on'";
          };
      };
    };
  };
}
