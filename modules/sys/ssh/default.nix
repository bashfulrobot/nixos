{ user-settings, pkgs, config, lib, ... }:
let cfg = config.sys.ssh;

in {

  options = {
    sys.ssh.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable ssh.";
    };
  };

  config = lib.mkIf cfg.enable {
    # Enable the OpenSSH daemon.
    services.openssh.enable = true;

    home-manager.users."${user-settings.user.username}" = {
      # services.ssh-agent.enable = false;
      # programs.ssh.addKeysToAgent = "yes";
      programs.ssh = {
        enable = true;
        extraConfig = ''
          Host github.com
            HostName github.com
            IdentityFile ~/.ssh/id_rsa
            User git
            AddKeysToAgent yes
          Host bitbucket.org
              HostName bitbucket.org
              User git
          # use 1password to manage ssh keys
          # Host *
          #   IdentityAgent ~/.1password/agent.sock
          #   AddKeysToAgent yes
          Host feral
              HostName aether.feralhosting.com
              User msgedme
          Host camino
            HostName 64.225.50.102
            User dustin
            IdentityFile ~/.ssh/id_rsa
            AddKeysToAgent yes
          Host remi
            HostName 72.51.28.133
            User dustin
            IdentityFile ~/.ssh/id_rsa
            AddKeysToAgent yes
          Host gigi
            HostName 100.96.21.6
            User dustin
            IdentityFile ~/.ssh/id_rsa
            AddKeysToAgent yes
          Host tower-ts
              HostName 100.89.2.33
              User dustin
              IdentityFile ~/.ssh/id_rsa
              AddKeysToAgent yes
          Host dt
              HostName 192.168.169.2
              User dustin
              IdentityFile ~/.ssh/id_rsa
              AddKeysToAgent yes
          Host ub-ubuntubudgieorg
              HostName 157.245.237.69
              User dustin
              IdentityFile ~/.ssh/id_rsa
              AddKeysToAgent yes
          Host ub-ubuntubudgieorg-nikola
              HostName 157.245.237.69
              User nikola
          Host ub-ubuntubudgieorg-webpub
              HostName 157.245.237.69
              User webpub
          Host ub-docker-root
              HostName 134.209.129.108
              User dustin
          Host ub-docker-admin
              HostName 134.209.129.108
              User docker-admin
          Host srv
              HostName 192.168.168.1
              User dustin
              IdentityFile ~/.ssh/id_rsa
              AddKeysToAgent yes
          Host srv-ts
                HostName 100.123.211.36
                User dustin
                IdentityFile ~/.ssh/id_rsa
                AddKeysToAgent yes
          Host 100.123.211.36
                User dustin
                IdentityFile ~/.ssh/id_rsa
                AddKeysToAgent yes
          Host nixdo
              HostName 192.168.168.10
              User dustin
              IdentityFile ~/.ssh/id_rsa
              AddKeysToAgent yes
          Host rembot
            HostName 100.89.186.70
            User dustin
            IdentityFile ~/.ssh/id_rsa
            AddKeysToAgent yes
        '';
      };

      # home.file."id_rsa" = {
      #   source = ../../../secrets/ssh/id_rsa;
      #   target = ".ssh/id_rsa";
      # };

      # home.file."id_rsa" = {
      #   source = ../../../secrets/ssh/id_rsa;
      #   target = ".ssh/id_rsa";
      # };

      # home.file."id_rsa.pub" = {
      #   source = ../../../secrets/ssh/id_rsa.pub;
      #   target = ".ssh/id_rsa.pub";
      # };

      # home.file."id_rsa.base64" = {
      #   source = ../../../secrets/ssh/id_rsa.base64;
      #   target = ".ssh/id_rsa.base64";
      # };

      # home.file."id_rsa.pub" = {
      #   source = ../../../secrets/ssh/id_rsa.pub;
      #   target = ".ssh/id_rsa.pub";
      # };

      # home.file."id_ed25519" = {
      #   source = ../../../secrets/ssh/id_ed25519;
      #   target = ".ssh/id_ed25519";
      # };

      # home.file."id_ed25519_np" = {
      #   source = ../../../secrets/ssh/id_ed25519_np;
      #   target = ".ssh/id_ed25519_np";
      # };

      # home.file."id_ed25519.pub" = {
      #   source = ../../../secrets/ssh/id_ed25519.pub;
      #   target = ".ssh/id_ed25519.pub";
      # };
    };
  };
}
