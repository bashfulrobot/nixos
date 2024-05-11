{ pkgs, config, lib, ... }:
let
  cfg = config.cli.helix;
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {

  options = {
    cli.helix.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable helix editor.";
    };

    cli.helix.enableGpt = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable helix-gpt.";
    };

    cli.helix.customConfig = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable custom helix config.";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      environment.systemPackages = with pkgs; [ helix ];

      home-manager.users."${username}" = {
        home = {
          sessionVariables = { EDITOR = "hx"; };
        };
      };
    })

    (lib.mkIf cfg.enableGpt {
      environment.systemPackages = with pkgs; [ helix-gpt ];

      home-manager.users."${username}" = {
        home = {
          sessionVariables = {
            COPILOT_API_KEY = "123"; # Required if using copilot handler
            HANDLER = "copilot";
          };

          file."languages.toml" = {
            source = ./config/languages.toml;
            target = ".helix/languages.toml";
          };
        };
      };
    })

    (lib.mkIf cfg.customConfig {
      home-manager.users."${username}" = {
        home.file."config.toml" = {
          source = ./config/config.toml;
          target = ".config/helix/config.toml";
        };
      };
    })
  ];
}