{ user-settings, catppuccin, pkgs, config, lib, inputs, ... }:
# valid accent, and themeAccents are convoluted. I needed to look at the source of the build, and the clones source of the theme to figure out what was going on.
# I also ran into an issue with files missing based on the way the asset names were being build dynamically bnased on my options. Again had to look at the source to figure out what was going on.
let
  cfg = config.desktops.sway.themes.catppuccin;
  # “latte”, “frappe”, “macchiato”, “mocha”
  themeFlavor = "macchiato";
  # "default" "purple" "pink" "red" "orange" "yellow" "green" "teal" "grey" "all"
  themeAccent = "blue";
  catppuccin-gtk-theme = pkgs.callPackage ./build {
    accent = [ "default" ];
    shade = "dark";
    size = "compact";
    tweaks = [ "macchiato" ];
  };
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
          background =
            "$HOME/Pictures/wallpapers/skullskates.png"; # TODO - universal setting
          font = "Work Sans";
          fontSize = "18";
        };
      };

    };

    environment.systemPackages = with pkgs; [
      catppuccin-gtk-theme
      # catppuccin-gtk
      catppuccin-cursors.macchiatoDark
      papirus-icon-theme
    ];

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
          "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
            document-font-name = "Work Sans 12";
            font-name = "Work Sans 12";
            monospace-font-name = "Victor Mono 13";
            # cursor-theme = "Catppuccin-Macchiato-Dark";
            # cursor-size = 24;
            gtk-theme = "catppuccin-gtk-theme-Dark-Compact-Macchiato";
            gtk-color-theme = "catppuccin-gtk-theme-Dark-Compact-Macchiato";
            icon-theme = "Papirus-Dark";
            text-scaling-factor = 1.0;
          };
        };
      };

      # gtk = {
      #   enable = true;
      #   cursorTheme = {
      #     name = "Catppuccin-Macchiato-Dark";
      #     package = pkgs.catppuccin-cursors.macchiatoDark;
      #   };
      #   iconTheme = {
      #     name = "Papirus-Dark";
      #     package = pkgs.papirus-icon-theme;
      #   };
      #   theme = {
      #     # https://discourse.nixos.org/t/gtk-settings-suddenly-not-applying/47381/9
      #     # name = "catppuccin-macchiato-blue-standard+default";
      #     # Needs to match tweaks
      #     name = "catppuccin-macchiato-blue-standard+rimless,black";

      #     package = pkgs.catppuccin-gtk.override {
      #       accents = [ themeAccent ];
      #       # “standard”, “compact”
      #       size = "compact";
      #       # “black”, “rimless”, “normal”
      #       tweaks = [ "rimless" "black" ];
      #       variant = themeFlavor;
      #     };
      #   };
      #   gtk3.extraConfig = {
      #     Settings = ''
      #       gtk-application-prefer-dark-theme=1
      #     '';
      #   };

      #   gtk4.extraConfig = {
      #     Settings = ''
      #       gtk-application-prefer-dark-theme=1
      #     '';
      #   };
      ### - Deprecated
      #   catppuccin = {
      #     enable = true;
      #     accent = themeAccent;
      #     flavor = themeFlavor;
      #     icon = {
      #       enable = true;
      #       accent = themeAccent;
      #     };
      #     # “standard”, “compact”
      #     size = "compact";
      #     # “black”, “rimless”, “normal”
      #     tweaks = [ "black" "rimless" ];
      #   };
      # };
    };
  };
}
