{ config, pkgs, ... }: {
  # Network CFG
  networking = {
    hostName = "srv";
    # nameservers = [ "1.1.1.1" "9.9.9.9" ];
    extraHosts = ''
      192.168.168.1 srv
    '';
    defaultGateway = "192.168.169.1";
    interfaces.enp3s0.ipv4 = {
      addresses = [{
        address = "192.168.168.1";
        prefixLength = 23;
      }];
    };
  };

  # Enable networking
  networking.networkmanager.enable = true;

}
