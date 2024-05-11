{ pkgs, config, lib, ... }:
let cfg = config.sys.hosts;
in {
  options = {
    sys.hosts.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable centralised hosts file.";
    };
  };

  config = lib.mkIf cfg.enable {
    # Network CFG
    networking = {
      extraHosts = ''
        192.168.168.10 nixdo docker
        192.168.169.2 rembot dt
        192.168.169.3 evo lt
        192.168.168.1 srv jf.srvrs.co fj.srvrs.co

      '';
    };
  };

}
