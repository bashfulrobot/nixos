{ config, ... }: {

  imports = [ ./default-apps.nix ];
  # add environment variables
  home.sessionVariables = {
    EDITOR = "nvim";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    MANROFFOPT = "-c";
  };
}
