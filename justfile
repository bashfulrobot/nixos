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
    @just --list --list-prefix ····
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
help:
    @just --help
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
# Final build and garbage collect
final-build:
    @just garbage-build-cache
    @just rebuild
    @just garbage-build-cache
# Final build and garbage collect, will reboot
final-build-reboot:
    @just garbage-build-cache
    @just rebuild
    @just garbage-build-cache
    @sudo reboot
# Rebuild nixos cfg on your current host.
rebuild:
    @sudo nixos-rebuild switch --impure --flake .#\{{`hostname`}}
    # @just _sway-reload
# Rebuild nixos cfg on your current host without git commit.
dev-rebuild:
    @git add -A
    @sudo nixos-rebuild switch --impure --flake .#\{{`hostname`}}
    # @just _sway-reload
# Test nixos cfg on your current host without git commit. Switches, but does not create a bootloader entry
dev-test:
    @git add -A
    @sudo nixos-rebuild test --impure --flake .#\{{`hostname`}}
# Test (with Trace) nixos cfg on your current host without git commit. Switches, but does not create a bootloader entry
dev-test-trace:
    @git add -A
    @sudo nixos-rebuild test --impure --flake .#\{{`hostname`}} --show-trace
# Rebuild and trace nixos cfg on your current host without git commit.
dev-rebuild-trace:
    @git add -A
    @sudo nixos-rebuild switch --impure --flake .#\{{`hostname`}} --show-trace
    # @just _sway-reload
# Rebuild nixos cfg on your current host with show-trace.
rebuild-trace:
    @sudo nixos-rebuild switch --impure --flake .#\{{`hostname`}} --show-trace
    @just _sway-reload
# Rebuild nixos cfg in a vm host with show-trace.
rebuild-vm:
    @sudo nixos-rebuild build-vm --impure --flake .#\{{`hostname`}} --show-trace
# Update Flake
upgrade-system:
    # @nix flake update --commit-lock-file
    @nix flake update
    @sudo nixos-rebuild switch --impure --upgrade --flake .#\{{`hostname`}} --show-trace
    # @just _sway-reload
# Garbage Collect items older than 5 days on the current host
garbage:
    @sudo nix-collect-garbage --delete-older-than 5d
# git reset and clean - unstage any changes and revert your working directory to the last commit,remove any untracked files and directories. Used to resolve conflicts due to syncthing
repo-conflict:
    @git reset --hard HEAD
    @git clean -fd
### The below will delete from the Nix store everything that is not used by the current generations of each  profile
# Garbage collect all, clear build cache
garbage-build-cache:
    @sudo nix-collect-garbage -d
# update nix database for use with comma
nixdb:
    nix run 'nixpkgs#nix-index' --extra-experimental-features 'nix-command flakes'
# lint nix files
nix-lint:
    fd -e nix --hidden --no-ignore --follow . -x statix check {}
# Update Hardware Firmware
run-fwup:
    @sudo fwupdmgr refresh --force
    @sudo fwupdmgr get-updates
    @sudo fwupdmgr update
all:
    just upgrade-system
    just garbage
