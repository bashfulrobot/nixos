{ ... }:
let
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {
  home-manager.users."${username}" = {
    ### GPG
    programs.gpg = { enable = true; };

    services.gpg-agent = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      # May not be needed. Testing
      # enableSshSupport = true;

    };

    ### Gnome-Keyring
    services.gnome-keyring = {
      enable = true;
      components = [ "pkcs11" "secrets" "ssh" ];
    };
  };
}
