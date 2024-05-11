{ pkgs, config, ... }:

{

  services.mako = {
    enable = true;
    defaultTimeout = 5000;
    backgroundColor = "#504945";
    borderColor = "#d3869b";
    borderRadius = 5;
    borderSize = 2;
    textColor = "#bdae93";
    # layer = "overlay";
    padding = "10,5,10,10";
  };

}
