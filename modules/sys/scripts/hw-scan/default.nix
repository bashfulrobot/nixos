{ user-settings, pkgs, lib, config, ... }:

let
  cfg = config.sys.scripts.hw-scan;
  hwScan = pkgs.writeShellApplication {
    name = "hw-scan";

    runtimeInputs = [ pkgs.docker ];

    text = ''
        #!/run/current-system/sw/bin/env bash

      sudo -E docker run -it \
            -v /dev:/dev:ro \
            -v /lib/modules:/lib/modules:ro \
            -v /etc/os-release:/etc/os-release:ro \
            -v /var/log:/var/log:ro \
            --privileged --net=host --pid=host \
            linuxhw/hw-probe -all -upload

       exit 0
    '';
  };
in {
  options = {
    sys.scripts.hw-scan.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the hw-scan script.";
    };
  };
  config = lib.mkIf cfg.enable {
    #   environment.systemPackages = [ hwScan ];
    home-manager.users."${user-settings.user.username}" = {
      home.packages = with pkgs; [ hwScan ];
    };
  };

}
