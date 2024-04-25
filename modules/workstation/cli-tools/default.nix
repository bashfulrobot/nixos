{ ... }:
let
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {

  imports = [ ./autojump ./espanso ];

  home-manager.users."${username}" = {
    programs = {
      tmux = { enable = true; };
      bat = { enable = true; };
      jq = { enable = true; };
      k9s = { enable = true; };
      btop = { enable = true; };
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
  };
}
