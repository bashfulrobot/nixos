{ config, pkgs, ... }: {
  # Network CFG
  networking = {
    hostName = "nixdo";
    nameservers = [ "8.8.8.8" "9.9.9.9" ];
    extraHosts = ''
      192.168.168.10 nixdo
    '';
    defaultGateway = "192.168.169.1";
    interfaces.enp1s0.ipv4 = {
      addresses = [{
        address = "192.168.168.10";
        prefixLength = 23;
      }];
    };
  };

  # Enable networking
  networking.networkmanager.enable = true;

}
