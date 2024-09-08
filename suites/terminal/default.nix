{ config, pkgs, lib, user-settings, ... }:
let cfg = config.suites.terminal;
in {

  options = {
    suites.terminal.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable terminal env..";
    };
  };

  config = lib.mkIf cfg.enable {
    cli = {
      alacritty.enable = true;
      bash.enable = true;
      fish.enable = true;
      zsh.enable = true;
      yazi.enable = true;
    };

    environment.systemPackages = with pkgs; [
      # --- Shell experience
      fzf # command-line fuzzy finder
      tealdeer # command-line help utility
      bottom # system monitoring tool
      jless # json/yaml parser
      fd # find alternative
      sd # sed alternative
      tree # directory structure viewer
      broot # Fuzzy finder
      eza # ls and exa alternative
    ];

    home-manager.users."${user-settings.user.username}" = {
      programs = {
        autojump = {
          enable = true;
          enableFishIntegration = true;
          enableBashIntegration = true;
          enableZshIntegration = true;
        };
        tmux = { enable = true; };
        bat = { enable = true; };

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
