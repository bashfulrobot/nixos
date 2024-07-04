{ user-settings, catppuccin, pkgs, config, lib, inputs, ... }:
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

    environment.systemPackages = with pkgs; [ catppuccin-gtk nwg-look ];

    home-manager.users."${user-settings.user.username}" = {
      # imports = [ inputs.catppuccin.homeManagerModules.catppuccin ];
      # Home-manager configuration
      catppuccin = {
        enable = true;
        flavor = themeFlavor;
        accent = themeAccent;
      };

      programs = {
        tofi.catppuccin = {
          enable = true;
          flavor = themeFlavor;
        };
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
        rofi.catppuccin = {
          enable = true;
          flavor = themeFlavor;
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

      dconf = {
        enable = true;
        settings = {
          "org/gnome/desktop/interface" = { color-scheme = "prefer-dark"; };
        };
      };

      gtk = {
        # enable = true;
        # cursorTheme = {
        #   name = "Catppuccin-Macchiato-Dark";
        #   package = pkgs.catppuccin-cursors.macchiatoDark;
        # };
        # iconTheme = {
        #   name = "Papirus-Dark";
        #   package = pkgs.papirus-icon-theme;
        # };
        # theme = {
        #   # https://discourse.nixos.org/t/gtk-settings-suddenly-not-applying/47381/9
        #   # name = "catppuccin-macchiato-blue-standard+default";
        #   # Needs to match tweaks
        #   name = "catppuccin-macchiato-blue-standard+rimless,black";

        #   package = pkgs.catppuccin-gtk.override {
        #     accents = [ themeAccent ];
        #     # “standard”, “compact”
        #     size = "compact";
        #     # “black”, “rimless”, “normal”
        #     tweaks = [ "rimless" "black" ];
        #     variant = themeFlavor;
        #   };
        # };
        # gtk3.extraConfig = {
        #   Settings = ''
        #     gtk-application-prefer-dark-theme=1
        #   '';
        # };

        # gtk4.extraConfig = {
        #   Settings = ''
        #     gtk-application-prefer-dark-theme=1
        #   '';
        # };
        ### - Deprecated
        catppuccin = {
          enable = true;
          accent = themeAccent;
          flavor = themeFlavor;
          icon = {
            enable = true;
            accent = themeAccent;
          };
          # “standard”, “compact”
          size = "compact";
          # “black”, “rimless”, “normal”
          tweaks = [ "black" "rimless" ];
        };
      };
    };
  };
}
