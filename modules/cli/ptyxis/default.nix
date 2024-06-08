{ user-settings, pkgs, secrets, config, lib, ... }:
let
  cfg = config.cli.ptyxis;

in {
  options = {
    cli.ptyxis.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable ptyxis terminal.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ ptyxis ];

};
}
