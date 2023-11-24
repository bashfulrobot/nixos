{ config, ... }: {

  imports = [ ./default-apps.nix ];
  # add environment variables
  home.sessionVariables = {
    EDITOR = "lvim";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    MANROFFOPT = "-c";
    XDG_CURRENT_DESKTOP = "gnome";
    XDG_SESSION_TYPE = "wayland";
  };
}
