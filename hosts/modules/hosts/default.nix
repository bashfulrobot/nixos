{ config, pkgs, ... }: {
  # Network CFG
  networking = {
    extraHosts = ''
      192.168.168.10 nixdo docker jellyfin
      192.168.169.2 rembot dt
      192.168.169.3 dustin-krysak lt
      192.168.168.1 srv
      192.168.169.24 rick multiverse
      192.168.169.25 morty
      192.168.169.26 summer

    '';
  };

}
