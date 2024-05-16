{ pkgs, config, lib, ... }:
let
  cfg = config.cli.common;
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {
  options = {
    cli.common.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable common cli tools.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [
        xdg-utils
      ];
    home-manager.users."${username}" = {
      programs = {
        autojump = {
          enable = true;
          enableFishIntegration = true;
        };
        tmux = { enable = true; };
        bat = { enable = true; };
        jq = { enable = true; };
        k9s = { enable = true; };
        btop = { enable = true; };
        # zellij = {
        #   enable = true;
        #   enableBashIntegration = true;
        # };
        # navi = {
        #   enable = true;
        #   enableBashIntegration = true;
        #   enableFishIntegration = true;
        # };

        carapace = { enable = true; };
      };
    };
  };
}
