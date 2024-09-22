{ config, pkgs, ... }: {
  # Network CFG
  networking = {

    hostName = "srv";

    nameservers = [ "1.1.1.1" "9.9.9.9" ];

    hosts =  {
      "192.168.168.1" = ["srv" "srv.goat-cloud.ts.net"];
      "127.0.0.1" = ["localhost"];
    };

    interfaces.enp3s0 = {
      useDHCP = false;
      ipv4.addresses = [{
        address = "192.168.168.1";
        prefixLength = 23;
      }];
    };

    defaultGateway = {
      address = "192.168.169.1";
      interface = "enp3s0";
    };

  };

  # Enable networking
  # networking.networkmanager.enable = true;

}
