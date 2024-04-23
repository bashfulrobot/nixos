{ ... }:
let
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {

  # add environment variables
  home-manager.users."${username}".home.sessionVariables = {
    EDITOR = "lvim";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    MANROFFOPT = "-c";
    XDG_CURRENT_DESKTOP = "gnome";
    XDG_SESSION_TYPE = "wayland";
    QT_QPA_PLATFORM = "wayland";
    NIXOS_OZONE_WL = 1; # fixed electron apps blurriness
    WARP_ENABLE_WAYLAND = 1; # Needed for Warp Terminal to use Wayland
  };
}
