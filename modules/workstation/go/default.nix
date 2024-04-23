{ ... }:
let
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {
  home-manager.users."${username}" = {
    programs.go = {
      enable = true;
      goBin = "go/bin";
      goPath = "go";
    };
  };
}
