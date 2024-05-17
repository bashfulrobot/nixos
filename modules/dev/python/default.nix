{ pkgs, config, lib, ... }:
let
  cfg = config.dev.python;
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {
  options = {
    dev.python.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Pythin tooling.";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users."${username}" = {
      home.packages = with pkgs;
        [
          (python3.withPackages (python-packages:
            with python-packages; [
              pip
              beautifulsoup4
              # black
              # flake8
              # setuptools
              # wheel
              # twine
              # flake8
              # virtualenv
            ]))
        ];
    };
  };
}