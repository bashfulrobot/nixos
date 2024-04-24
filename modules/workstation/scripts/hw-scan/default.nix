{ pkgs, ... }:
let
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
  home-manager.users."${username}" = {
    home.packages = with pkgs;
      [
        (writeScriptBin "hardware-scan.sh" hwScan)

      ];
  };
}
