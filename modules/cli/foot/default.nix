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
            # font = "Fira Code:size=12";
            # font = "Code OnePiece:size=26, Noto Color Emoji:size=25";
            # font-bold = "Code OnePiece:size=26, Noto Color Emoji:size=25";
            letter-spacing = "1";
            box-drawings-uses-font-glyphs = "no";
            pad = "12x12";
            # pad = "0x0center";
            dpi-aware = "yes";
            selection-target = "both";
          };

          scrollback = {
            lines = 10000;
            multiplier = 3;
          };

          mouse = { hide-when-typing = "yes"; };

          key-bindings = {
            clipboard-copy = "Control+Shift+c";
            clipboard-paste = "Control+Shift+v Control+y";
            primary-paste = "Shift+Insert";
          };

        };
      };

    };
  };
}
