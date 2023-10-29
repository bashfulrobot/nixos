{ config, lib, pkgs, ... }:

{
  # sddm dependencies
  environment.systemPackages = with pkgs; [
    pkgs.libsForQt5.qt5.qtquickcontrols2 # sddm theme
    pkgs.libsForQt5.qt5.qtgraphicaleffects # sddm theme
    pkgs.crudini # Used when building the SDDM themes - edit INI files in place

  ];
}
