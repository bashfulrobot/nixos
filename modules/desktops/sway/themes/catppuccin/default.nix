{ user-settings, catppuccin, pkgs, config, lib, ... }:
let
  cfg = config.desktops.sway.themes.catppuccin;
  # “latte”, “frappe”, “macchiato”, “mocha”
  themeFlavor = "macchiato";
  # “blue”, “flamingo”, “green”, “lavender”, “maroon”, “mauve”, “peach”, “pink”, “red”, “rosewater”, “sapphire”, “sky”, “teal”, “yellow”
  themeAccent = "mauve";
in {

  options = {
    desktops.sway.themes.catppuccin.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the catppuccin theme for sway.";
    };
  };

  config = lib.mkIf cfg.enable {

    # Regular nix configuration
    catppuccin = {
      enable = true;
      flavor = themeFlavor;
      accent = themeAccent;

    };

    boot.loader.grub.catppuccin = {
      enable = true;
      flavor = themeFlavor;

    };

    services = {
      displayManager = {

        sddm.catppuccin = {
          enable = true;
          flavor = themeFlavor;
          background = "~/Pictures/wallpapers/skullskates.png";
          font = "Work Sans";
          fontSize = "18";
        };
      };

    };

    environment.systemPackages = with pkgs; [ catppuccin-gtk ];

    home-manager.users."${user-settings.user.username}" = {
      # Home-manager configuration
      catppuccin = {
        enable = true;
        flavor = themeFlavor;
        accent = themeAccent;
      };

      programs = {
        waybar.catppuccin = {
          enable = true;
          flavor = themeFlavor;
        };
        tmux.catppuccin = {
          enable = true;
          flavor = themeFlavor;
        };
        swaylock.catppuccin = {
          enable = true;
          flavor = themeFlavor;
        };
        neovim.catppuccin = {
          enable = true;
          flavor = themeFlavor;
        };
        mpv.catppuccin = {
          enable = true;
          flavor = themeFlavor;
        };
        lazygit.catppuccin = {
          enable = true;
          flavor = themeFlavor;
          accent = themeAccent;
        };
        k9s.catppuccin = {
          enable = true;
          flavor = themeFlavor;
        };
        gitui.catppuccin = {
          enable = true;
          flavor = themeFlavor;
        };
        fzf.catppuccin = {
          enable = true;
          flavor = themeFlavor;
        };
        foot = {
          catppuccin = {
            enable = true;
            flavor = themeFlavor;
          };
        };
      };
      services = {
        mako.catppuccin = {
          enable = true;
          flavor = themeFlavor;
        };
      };

      wayland.windowManager.sway.catppuccin = {
        enable = true;
        flavor = themeFlavor;
      };

      gtk = {
        catppuccin = {
          enable = true;
          accent = themeAccent;
          flavor = themeFlavor;
          icon = {
            enable = true;
            accent = themeAccent;
          };
          # “standard”, “compact”
          size = "normal";
          # “black”, “rimless”, “normal”
          tweaks = [ "black" ];
        };
      };
    };
  };
}
