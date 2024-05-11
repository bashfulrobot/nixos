{ pkgs, config, lib, ... }:
let
  cfg = config.sys.scripts.hw-scan;
  hwScan = ''
    #!/usr/bin/env bash

    sudo -E docker run -it \
          -v /dev:/dev:ro \
          -v /lib/modules:/lib/modules:ro \
          -v /etc/os-release:/etc/os-release:ro \
          -v /var/log:/var/log:ro \
          --privileged --net=host --pid=host \
          linuxhw/hw-probe -all -upload

     exit 0

  '';

  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {
  options = {
    sys.scripts.hw-scan.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the hw-scan script.";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users."${username}" = {
      home.packages = with pkgs;
        [
          (writeScriptBin "hardware-scan.sh" hwScan)

        ];
    };
  };
}
