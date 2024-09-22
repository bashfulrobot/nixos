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
      starship.enable = true;
      alacritty.enable = false;
      bash.enable = true;
      fish.enable = true;
      zsh.enable = true;
      yazi.enable = true;
    };

    # A fuse filesystem that dynamically populates contents of /bin and /usr/bin/ so that it contains all executables from the PATH of the requesting process. This allows executing FHS based programs on a non-FHS system. For example, this is useful to execute shebangs on NixOS that assume hard coded locations like /bin or /usr/bin etc.
    services.envfs.enable = true;

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
			btop # top alternative
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
