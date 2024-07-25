{ pkgs }:

pkgs.writeShellApplication {
  name = "dbus-hyprland-environment";

  runtimeInputs = [ ];

  text = ''
    #!/run/current-system/sw/bin/env bash

    dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP SWAYSOCK QT_QPA_PLATFORMTHEME XDG_RUNTIME_DIR
    dbus-update-activation-environment --systemd --all
    #systemctl --user import-environment QT_QPA_PLATFORMTHEME

    systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-hyprland xdg-desktop-portal-gtk
    systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-hyprland xdg-desktop-portal-gtk
  '';
}
