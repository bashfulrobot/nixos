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
#         dustin-krysak|rembot) \
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
# Rebuild nixos cfg on your current host.
rebuild:
    @sudo nixos-rebuild switch --impure --flake .#\{{`hostname`}}
    # @just _sway-reload
# Rebuild nixos cfg on your current host without git commit.
dev-rebuild:
    @git add .
    @sudo nixos-rebuild switch --impure --flake .#\{{`hostname`}}
    # @just _sway-reload
# Rebuild nixos cfg on your current host with show-trace.
rebuild-trace:
    @sudo nixos-rebuild switch --impure --flake .#\{{`hostname`}} --show-trace
    @just _sway-reload
# Update Flake
upgrade-system:
    @nix flake update --commit-lock-file
    @sudo nixos-rebuild switch --impure --upgrade --flake .#\{{`hostname`}} --show-trace
    # @just _sway-reload
# Upgrade Release Flake
upgrade-release:
    @nix flake update --commit-lock-file
    @sudo nixos-rebuild boot --impure --upgrade --flake .#\{{`hostname`}} --show-trace
# Upgrade System
update-flake:
    @nix flake update --commit-lock-file
# Update Flake & Rebuild nixos cfg on your current host.
update-rebuild:
    just update-flake
    just rebuild
# Garbage collect the current host
garbage:
    # @sudo nix-collect-garbage -d
    @sudo nix-collect-garbage --delete-older-than 7d
# Run garbage collect, update and rebuild
# Update Hardware Firmware
run-fwup:
    @sudo fwupdmgr refresh
    @sudo fwupdmgr get-updates
    @sudo fwupdmgr update
all:
    just upgrade-system
    just garbage
