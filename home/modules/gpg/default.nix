{ pkgs, config, ... }:

{

  ### GPG
  programs.gpg = { enable = true; };

  services.gpg-agent = {
    enable = true;
    enableBashIntegration = true;
    # May not be needed. Testing
    # enableSshSupport = true;
  };

  ### Gnome-Keyring
  services.gnome-keyring = {
    enable = true;
    components = [ "pkcs11" "secrets" "ssh" ];
  };



}
