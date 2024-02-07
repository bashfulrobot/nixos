# ~/.config/autostart

{ config, lib, ... }:

{

  home.file."solaar.desktop" = {
    source = ./solaar.desktop;
    target = ".config/autostart/solaar.desktop";
  };
}
