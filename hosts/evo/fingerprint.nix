{ pkgs, ... }: {

  environment.systemPackages = [

  ];

  services.fprintd = {
    enable = true;
    tod = {
      enable = true;
      driver = pkgs.libfprint-2-tod1-goodix;
    };

  };


}
