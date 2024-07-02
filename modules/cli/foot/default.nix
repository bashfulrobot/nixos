{ user-settings, pkgs, secrets, config, lib, ... }:
let cfg = config.cli.foot;
in {
  options = {
    cli.foot.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable foot terminal.";
    };
  };

  config = lib.mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [  ];

    home-manager.users."${user-settings.user.username}" = {

      programs.foot = {
        enable = true;
        # server.enable = true;
        settings = {
          main = {
            shell = "${pkgs.fish}/bin/fish";
            font = "Fira Code:size=12";
            pad = "12x12";
            dpi-aware = "yes";
            selection-target = "both";
          };
          mouse = { hide-when-typing = "yes"; };

        };
      };

    };
  };
}
