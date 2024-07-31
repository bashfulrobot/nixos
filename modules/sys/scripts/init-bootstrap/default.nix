{ user-settings, pkgs, lib, config, ... }:

let
  cfg = config.sys.scripts.init-bootstrap;
  initBootstrap = pkgs.writeShellApplication {
    name = "init-bootstrap";

    runtimeInputs = [ ];

    text = ''
      #!/run/current-system/sw/bin/env bash

      echo "remember to grab the hardware configuration file from the bootstrapped system in /bootstrapped"
      sleep 5

      1password
      echo "Please log in to 1Password GUI, and enable the CLI and press Enter to continue..."
      read -p ""
      op read "op://Personal/ssh_key_id_rsa/public key" > ~/.ssh/id_rsa.pub
      op read "op://Personal/ssh_key_id_rsa/private key" > ~/.ssh/id_rsa
      op read "op://Personal/ssh_key_id_ed25519/public key" > ~/.ssh/id_ed25519.pub
      op read "op://Personal/ssh_key_id_ed25519/private key" > ~/.ssh/id_ed25519
      op document get "git-crypt-key" --out-file=./git-crypt-key
      mv ./git-crypt-key ~/.gnupg/git-crypt-key
      sudo chown -R $(whoami):users ~/.ssh/id_rsa ~/.ssh/id_ed25519 ~/.gnupg/git-crypt-key
      chmod 600 ~/.ssh/id_rsa ~/.ssh/id_ed25519
      chmod 700 ~/.gnupg/git-crypt-key
      mkdir -p ~/dev/nix/
      sudo mv /bootstrapped ~/dev/nix/
      sudo chown -R $(whoami):users ~/dev/nix/bootstrapped
      echo "still need to do:"
      echo
      echo

      exit 0
    '';
  };
in {
  options = {
    sys.scripts.init-bootstrap.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the init-bootstrap script.";
    };
  };
  config = lib.mkIf cfg.enable {
    #   environment.systemPackages = [ initBootstrap ];
    home-manager.users."${user-settings.user.username}" = {
      home.packages = with pkgs; [ initBootstrap ];
    };
  };

}
