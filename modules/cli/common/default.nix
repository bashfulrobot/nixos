{ user-settings, pkgs, config, lib, ... }:
let
  cfg = config.cli.common;

in {
  options = {
    cli.common.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable common cli tools.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ xdg-utils tcpdump silver-searcher ];

    # programs.nh = {
    #   enable = true;
    #   clean.enable = true;
    #   clean.extraArgs = "--keep-since 4d --keep 3";
    #   flake = "/home/dustin/dev/nix/nixos";
    # };
    home-manager.users."${user-settings.user.username}" = {
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
