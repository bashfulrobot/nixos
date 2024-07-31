# run with:
# export NIXPKGS_ALLOW_UNFREE=1; nix-shell --impure shell.nix
{ pkgs ? import <nixpkgs> { } }:
let
  # Define the bash script
  bootstrapScript = ''
    #!/run/current-system/sw/bin/env bash

          WORKING_DIR="/tmp/bootstrap"

          mkdir -p $WORKING_DIR/.ssh
          mkdir -p $WORKING_DIR/.gnupg
          cd $WORKING_DIR
          git clone https://github.com/bashfulrobot/nixos
          cd nixos
          nohup 1password &
          echo "Please log in to 1Password GUI, and export keys and press Enter to continue..."
          read -r -p ""
          mv /home/nixos/Downloads/git-crypt-key $WORKING_DIR/.gnupg/git-crypt-key
          mv /home/nixos/Downloads/id_rsa.pub $WORKING_DIR/.ssh/id_rsa.pub
          mv /home/nixos/Downloads/id_rsa $WORKING_DIR/.ssh/id_rsa
          mv /home/nixos/Downloads/id_ed25519.pub $WORKING_DIR/.ssh/id_ed25519.pub
          mv /home/nixos/Downloads/id_ed25519 $WORKING_DIR/.ssh/id_ed25519
          chmod 600 $WORKING_DIR/.ssh/id_* $WORKING_DIR/.gnupg/git-crypt-key
          git-crypt unlock $WORKING_DIR/.gnupg/git-crypt-key
          git-crypt status -f
          git-crypt status

          # Prompt for system name
          echo "Select a system name:"
          echo "1) rembot"
          echo "2) evo"
          read -r -p "Enter the number corresponding to your choice: " system_choice

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

        sudo mount | grep /mnt

        sudo nixos-generate-config --no-filesystems --root /mnt

        sudo cp /mnt/etc/nixos/hardware-configuration.nix $WORKING_DIR/nixos/systems/$SYSTEM_NAME/hardware/hardware-configuration.nix

        sudo mkdir -p /mnt/bootstrapped/$SYSTEM_NAME

        sudo cp -r $WORKING_DIR /mnt/bootstrapped/$SYSTEM_NAME/

        # Run nixos-install against an impure flake in $WORKING_DIR/nixos
        ulimit -n 4096
        sudo nixos-install --flake "$WORKING_DIR/nixos#$SYSTEM_NAME" --impure
  '';

  # Create the shell application using writeShellApplication
  bootstrap = pkgs.writeShellApplication {
    name = "bootstrap";
    runtimeInputs = [ pkgs.bash ];
    text = bootstrapScript;
  };
in pkgs.mkShell {
  # nativeBuildInputs is usually what you want -- tools you need to run
  nativeBuildInputs = with pkgs.buildPackages; [
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
    bootstrap
  ];
}
