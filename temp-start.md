mkdir -p ~/dev/nix && cd ~/dev/nix
export NIXPKGS_ALLOW_UNFREE=1; nix-shell -p vscode just git nixfmt _1password-gui
git clone <https://github.com/bashfulrobot/nixos>
cd ~/dev/nix/nixos
code . # edit new machine config
rm ~/.config/mimeapps.list
sudo nixos-rebuild switch --impure --flake .#dustin-krysak

# cp .gnupg folder into place

```shell
git remote rm origin
git remote add origin git@github.com:bashfulrobot/nixos.git
git push --set-upstream origin main
```

# commit
