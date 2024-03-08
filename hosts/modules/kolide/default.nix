{ pkgs, config, inputs, lib, ... }: {

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "kolide-launcher-1.5.3" ];
  # Install necessary packages
  # environment.systemPackages = [
  #   inputs.kolide-launcher
  # ];

  environment.etc."kolide-k2/secret" = {
    mode = "0600";
    text = "";
  };

  services.kolide-launcher = {
    enable = true;
    kolideHostname = "dustin-krysak";
    # updateChannel = "nightly";
  };
}
