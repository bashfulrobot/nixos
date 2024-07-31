# Shell for bootstrapping flake-enabled nix and home-manager
# Access development shell with  'nix develop' or (legacy) 'nix-shell'
{ pkgs ? import <nixpkgs> { } }: {
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

          # Prompt for system name
          echo "Select a system name:"
          echo "1) rembot"
          echo "2) evo"
          read -p "Enter the number corresponding to your choice: " system_choice

          case $system_choice in
            1)
              SYSTEM_NAME="rembot"
              ;;
            2)
              SYSTEM_NAME="evo"
              ;;
            *)
              echo "Invalid selection"
              exit 1
              ;;
          esac

        sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko $WORKING_DIR/nixos/systems/$SYSTEM_NAME/hardware/disko.nix

        mount | grep /mnt

        nixos-generate-config --no-filesystems --root /mnt

        cp /mnt/etc/nixos/hardware-configuration.nix $WORKING_DIR/nixos/systems/$SYSTEM_NAME/hardware/hardware-configuration.nix

        cp -r $WORKING_DIR /mnt/bootstrapped/${SYSTEM_NAME}/

        # Run nixos-install against an impure flake in $WORKING_DIR/nixos
        nixos-install --flake "$WORKING_DIR/nixos#${SYSTEM_NAME}" --impure

      '';

      nativeBuildInputs = with pkgs; [
        nix
        home-manager
        git
        git-crypt
        neovim
        just
        fish
        vscode
        nano
        just
        nixfmt
        statix
        _1password-gui
        _1password
        wget
        unzip
        lsblk
        bootstrapScript
      ];
      shellHook = ''
        exec fish
      '';
    };
  };
}
