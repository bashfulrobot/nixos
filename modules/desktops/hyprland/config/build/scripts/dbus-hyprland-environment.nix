{ pkgs }:

pkgs.writeShellApplication {
  name = "dbus-hyprland-environment";

  runtimeInputs = [ ];

  text = ''
    #!/run/current-system/sw/bin/env bash

    dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    dbus-update-activation-environment --systemd --all

    systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-hyprland xdg-desktop-portal-gtk
    systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-hyprland xdg-desktop-portal-gtk
  '';
}
