{ pkgs, ... }: {
  programs = {
    tmux = { enable = true; };
    bat = { enable = true; };
    jq = { enable = true; };
    k9s = { enable = true; };
    # zellij = {
    #   enable = true;
    #   enableBashIntegration = true;
    # };
    # navi = {
    #   enable = true;
    #   enableBashIntegration = true;
    #   enableFishIntegration = true;
    # };

    carapace = { enable = true; };
  };
}
