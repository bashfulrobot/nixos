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

      cd /bootstrapped/"$(hostname)"/
      cp .gnupg/git-crypt-key ~/.gnupg/git-crypt-key
      cp .ssh/id_* ~/.ssh/
      sudo chown -R "$(whoami)":users ~/.ssh/id_* ~/.gnupg/git-crypt-key
      chmod 600 ~/.ssh/id_*
      chmod 700 ~/.gnupg/git-crypt-key
      mkdir -p ~/dev/nix/
      sudo mv /bootstrapped ~/dev/nix/
      sudo chown -R "$(whoami)":users ~/dev/nix/bootstrapped
      sudo chmod 700 ~/dev/nix/bootstrapped
      echo "still need to do:"
      echo
      echo "- sudo tailscale login —accept-routes=true —ssh"
      echo "- Update Tailscale name"
      echo "- Set key to not expire"
      echo "- Update Tailscale ips in syncthing"
      echo "- Ensure ids are correct in syncthing"
      echo "- Rebuild"
      echo "- Check if syncthing is working. (localhost:8384)"

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
