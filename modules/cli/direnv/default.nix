{ user-settings, pkgs, secrets, config, lib, ... }:
let cfg = config.cli.direnv;

in {
  options = {
    cli.direnv.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable direnv and envsubst.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ envsubst ];

    home-manager.users."${user-settings.user.username}" = {
      programs.direnv = {
        enable = true;
        # caching builds
        # https://github.com/nix-community/nix-direnv
        nix-direnv.enable = true;
        enableBashIntegration = true;
        config.global = {
          load_dotenv = true;
          strict_env = true;
          warn_timeout = "400ms";
        };
      };
    };
  };
}
