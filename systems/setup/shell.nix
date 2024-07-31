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
        mkdir -p ~/dev/nix
        cd ~/dev/nix
        wget https://github.com/bashfulrobot/nixos/archive/refs/heads/main.zip
        unzip main.zip
        mv nixos-main nixos
        cd nixos

      '';
    };

    nativeBuildInputs = with pkgs; [ nix home-manager git git-crypt neovim just fish vscode just nixfmt _1password-gui wget unzip bootstrapScript];
    shellHook = ''
      exec fish
    '';
  };
}
