{ user-settings, lib, inputs, pkgs, config, ... }:
let cfg = config.apps.insync;

in {
  options = {
    apps.insync.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable gdrive sync.";
    };

  };

  config = lib.mkIf cfg.enable {

    # use regular package
    environment.systemPackages = with pkgs; [ insync insync-nautilus insync-emblems-icons ];

    home-manager.users."${user-settings.user.username}" = {

    };
  };
}
