{ pkgs, secrets, config, lib, ... }:
let
  cfg = config.cli.ptyxis;
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {
  options = {
    cli.ptyxis.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable spotify_player.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ ptyxis ];

};
}
