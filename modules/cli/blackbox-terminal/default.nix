{ user-settings, pkgs, inputs, lib, config, ... }:
let
  cfg = config.cli.blackbox-terminal;

in {
  options = {
    cli.blackbox-terminal.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable centralised hosts file.";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users."${user-settings.user.username}" = {

      home.packages = with pkgs;
        [
          blackbox-terminal # encrypted terminal sessions
        ];

      dconf.settings = with inputs.home-manager.lib.hm.gvariant; {

        "com/raggesilver/BlackBox" = {
          context-aware-header-bar = true;
          custom-working-directory = "/home/dustin/dev";
          easy-copy-paste = true;
          font = "MesloLGS NF 16";
          headerbar-drag-area = false;
          notify-process-completion = true;
          opacity = mkUint32 90;
          scrollback-lines = mkUint32 10000;
          show-headerbar = true;
          terminal-cell-height = 1.0;
          terminal-cell-width = 1.0;
          terminal-padding =
            mkTuple [ (mkUint32 0) (mkUint32 0) (mkUint32 0) (mkUint32 0) ];
          theme-bold-is-bright = true;
          # theme-dark = "Dracula"; # Done in themes directory
          window-height = mkUint32 1156;
          window-width = mkUint32 948;
          working-directory-mode = mkUint32 2;
        };

      };
    };
  };
}
