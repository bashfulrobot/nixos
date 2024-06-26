{ user-settings, pkgs, secrets, config, lib, ... }:
let
  cfg = config.cli.helix;

in {
  options = {
    cli.helix.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable helix editor.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ helix helix-gpt ];

    home-manager.users."${user-settings.user.username}" = {

      home = {
        sessionVariables = {
          EDITOR = "hx";
          COPILOT_API_KEY =
            "${secrets.helix-gpt.api-key}"; # Required if using copilot handler
          HANDLER = "copilot";
        };
        # file."languages.toml" = {
        #   source = ./config/languages.toml;
        #   target = ".helix/languages.toml";
        # };
        # file."config.toml" = {
        #   source = ./config/config.toml;
        #   target = ".config/helix/config.toml";
        # };
      };

    };
  };
}
