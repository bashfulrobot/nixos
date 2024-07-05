{ pkgs }:

pkgs.writeShellApplication {
  name = "dbus-sway-environment";

  runtimeInputs = [ ];

  text = ''
    #!/usr/bin/env bash

    dbus-update-activation-environment --systemd DISPLAY SWAYSOCK WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
    systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
    systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
  '';
}