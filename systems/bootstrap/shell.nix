# Shell for bootstrapping flake-enabled nix and home-manager
# Access development shell with  'nix develop' or (legacy) 'nix-shell'
{ pkgs ? (import ./nixpkgs.nix) { } }: {
  default = pkgs.mkShell {
    name = "bashfulrobot-bootstrap--flake";
    # Enable experimental features without having to specify the argument
    NIX_CONFIG = "experimental-features = nix-command flakes";

    # Define the bootstrap bash script
    bootstrapScript = pkgs.writeShellApplication {
      name = "bootstrap";
      runtimeInputs = [ pkgs.bash ];
      text = ''
        #!/run/current-system/sw/bin/env bash

        WORKING_DIR="/tmp/bootstrap"

        mkdir -p $WORKING_DIR/.ssh
        mkdir -p $WORKING_DIR/.gnupg
        cd $WORKING_DIR
        wget https://github.com/bashfulrobot/nixos/archive/refs/heads/main.zip
        unzip main.zip
        mv nixos-main nixos
        cd nixos
        1password
        echo "Please log in to 1Password GUI, and enable the CLI and press Enter to continue..."
        read -p ""
        op read "op://Personal/ssh_key_id_rsa/public key" > $WORKING_DIR/id_rsa.pub
        op read "op://Personal/ssh_key_id_rsa/private key" > $WORKING_DIR/id_rsa
        op read "op://Personal/ssh_key_id_ed25519/public key" > $WORKING_DIR/id_ed25519.pub
        op read "op://Personal/ssh_key_id_ed25519/private key" > $WORKING_DIR/id_ed25519
        op document get "git-crypt-key" --out-file=./git-crypt-key
        mv ./git-crypt-key $WORKING_DIR/git-crypt-key
        chmod 600 $WORKING_DIR/id_rsa $WORKING_DIR/id_ed25519 $WORKING_DIR/git-crypt-key
        git-crypt unlock $WORKING_DIR/git-crypt-key
        git-crypt status -f
        git-crypt status


      '';
    };

    nativeBuildInputs = with pkgs; [
      nix
      home-manager
      git
      git-crypt
      neovim
      just
      fish
      vscode
      just
      nixfmt
      _1password-gui
      _1password
      wget
      unzip
      bootstrapScript
    ];
    shellHook = ''
      exec fish
    '';
  };
}
