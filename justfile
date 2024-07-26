# Docs
# ---- https://github.com/casey/just
# ---- https://stackabuse.com/how-to-change-the-output-color-of-echo-in-linux/
# ---- https://cheatography.com/linux-china/cheat-sheets/justfile/
# load a .env file if in the directory
set dotenv-load
# Ignore recipe lines beginning with #.
set ignore-comments
# Search justfile in parent directory if the first recipe on the command line is not found.
set fallback

# "_" hides the recipie from listings
_default:
    @just --list --unsorted --list-prefix ····
# _default:
#     @just --choose
# _sway-reload:
#     @case $(hostname) in \
#         evo|rembot) \
#             swaymsg reload; \
#             echo "Sway reloaded...";; \
#         *) \
#             echo "Skipping sway reload...";; \
#     esac

# Print `just` help
# help:
#     @just --help
# # Print your hostname
# host:
#     @echo `hostname`
# # Print your user name
# user:
#     @echo {{env_var('USER')}}
# # Print your homedir
# home:
#     @echo {{env_var('HOME')}}
# # Print the directory where the justfile is located
# root:
#     @echo {{justfile_directory()}}
# Test nixos cfg on your current host without git commit. Switches, but does not create a bootloader entry
dev-test:
    @git add -A
    # @just garbage-build-cache
    # @sudo nixos-rebuild test --fast--impure --flake .#\{{`hostname`}}
    @sudo nixos-rebuild dry-build --fast --impure --flake .#\{{`hostname`}}
# git reset and clean - unstage any changes and revert your working directory to the last commit,remove any untracked files and directories. Used to resolve conflicts due to syncthing
repo-conflict:
    @git reset --hard HEAD
    @git clean -fd
    @git pull
# lint nix files
nix-lint:
    fd -e nix --hidden --no-ignore --follow . -x statix check {}
# Rebuild nixos cfg on your current host without git commit.
dev-rebuild:
    @git add -A
    @sudo nixos-rebuild switch --impure --flake .#rembot
    # @just _sway-reload
# Rebuild nixos cfg without the cache.
dev-rebuild-no-cache:
    @git add -A
    @sudo nixos-rebuild switch --impure --flake .#rembot --option binary-caches ''
    # @just _sway-reload
# Final build and garbage collect, will reboot
final-build-reboot:
    @just garbage-build-cache
    @just rebuild
    @just garbage-build-cache
    @sudo reboot
# Update Flake
upgrade-system:
    # @nix flake update --commit-lock-file
    @cp flake.lock flake.lock-pre-upg-$(hostname)-$(date +%Y-%m-%d_%H-%M-%S)
    @nix flake update
    @sudo nixos-rebuild switch --impure --upgrade --flake .#\{{`hostname`}} --show-trace
    # @just _sway-reload
# update nix database for use with comma
nixdb:
    nix run 'nixpkgs#nix-index' --extra-experimental-features 'nix-command flakes'
# Update Hardware Firmware
run-fwup:
    @sudo fwupdmgr refresh --force
    @sudo fwupdmgr get-updates
    @sudo fwupdmgr update
# Rebuild nixos cfg on your current host.
rebuild:
    @sudo nixos-rebuild switch --impure --flake .#\{{`hostname`}}
    # @just _sway-reload

# Test (with Trace) nixos cfg on your current host without git commit. Switches, but does not create a bootloader entry
dev-test-trace:
    @git add -A
    @just garbage-build-cache
    @sudo nixos-rebuild test --impure --flake .#\{{`hostname`}} --show-trace
# Rebuild and trace nixos cfg on your current host without git commit.
dev-rebuild-trace:
    @git add -A
    @just garbage-build-cache
    @sudo nixos-rebuild switch --impure --flake .#\{{`hostname`}} --show-trace > ~/dev/nix/nixos/rebuild-trace.log 2>&1
    # @just _sway-reload
# Rebuild nixos cfg on your current host with show-trace.
rebuild-trace:
    @sudo nixos-rebuild switch --impure --flake .#\{{`hostname`}} --show-trace
    @just _sway-reload
# Rebuild nixos cfg in a vm host with show-trace.
rebuild-vm:
    @sudo nixos-rebuild build-vm --impure --flake .#\{{`hostname`}} --show-trace

# Garbage Collect items older than 5 days on the current host
garbage:
    @sudo nix-collect-garbage --delete-older-than 5d
### The below will delete from the Nix store everything that is not used by the current generations of each  profile
# Garbage collect all, clear build cache
garbage-build-cache:
    @sudo nix-collect-garbage -d
