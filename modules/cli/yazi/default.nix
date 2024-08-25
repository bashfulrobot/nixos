{ user-settings, pkgs, secrets, config, lib, ... }:
let cfg = config.cli.yazi;
in {
  options = {
    cli.yazi.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable yazi file browser.";
    };
  };

  config = lib.mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [  ];

    home-manager.users."${user-settings.user.username}" = {

      programs.yazi = {
        enable = true;
        enableBashIntegration = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
      };

    };
  };
}
