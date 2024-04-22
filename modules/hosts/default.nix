{ config, ... }: {
  # Network CFG
  networking = {
    extraHosts = ''
      192.168.168.10 nixdo docker
      192.168.169.2 rembot dt
      192.168.169.3 dustin-krysak lt
      192.168.168.1 srv jf.srvrs.co fj.srvrs.co

    '';
  };

}
