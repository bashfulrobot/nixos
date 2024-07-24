# https://github.com/budimanjojo/dotfiles
# valid accent, and themeAccents are convoluted. I needed to look at the source of the build, and the clones source of the theme to figure out what was going on.
# I also ran into an issue with files missing based on the way the asset names were being build dynamically bnased on my options. Again had to look at the source to figure out what was going on.
{ user-settings, pkgs, config, lib, inputs, ... }:
let

  cfg = config.desktops.hyprland.config.theme;

  # Import the makeDesktopApp function
  hexToRgba = pkgs.callPackage ../../../../lib/hex-to-rgba { };

  # from user-settings
  theme = user-settings.theme.CatppuccinMacchiato;

  # “latte”, “frappe”, “macchiato”, “mocha”
  themeFlavor = "macchiato";
  # "default" "purple" "pink" "red" "orange" "yellow" "green" "teal" "grey" "all"
  themeAccent = "blue";
  catppuccin-gtk-theme = pkgs.callPackage ./build/catppuccin {
    accent = [ "default" ];
    shade = "dark";
    size = "compact";
    tweaks = [ "macchiato" ];
  };

  shadowColorRgba = hexToRgba {
    hexColor = theme.shadow;
    opacity = 0.6;
  };

  bgColorRgba = hexToRgba {
    hexColor = theme.background;
    opacity = 1.0; # solid
  };

in {

  options = {
    desktops.hyprland.config.theme.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Hyprland Theme Settings";
    };
  };
  config = lib.mkIf cfg.enable {

    # Regular nix configuration
    # catppuccin = {
    #   enable = true;
    #   flavor = themeFlavor;
    #   accent = themeAccent;

    # };

    boot.loader.grub.catppuccin = {
      enable = true;
      flavor = themeFlavor;
    };

    environment.systemPackages = with pkgs; [
      catppuccin-gtk-theme
      # catppuccin-gtk
      catppuccin-cursors.macchiatoDark
      papirus-icon-theme
    ];

    ##### Home Manager Config options #####
    home-manager.users."${user-settings.user.username}" = {

      #  TESTING
      # catppuccin = {
      #   enable = true;
      #   flavor = themeFlavor;
      #   accent = themeAccent;
      # };

      programs = {

        waybar.catppuccin = {
          enable = true;
          flavor = themeFlavor;
        };
        tmux.catppuccin = {
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
      # END TESTING

      wayland.windowManager = {
        hyprland = {
          # Testing
          catppuccin = {
            enable = true;
            flavor = themeFlavor;
          };

          settings = {

            general = {
              gaps_in = 3;
              gaps_out = 20;
              border_size = 0;
            };

            misc = {
              disable_hyprland_logo = true;
              background_color = bgColorRgba;
              disable_splash_rendering = true;
              animate_manual_resizes = true;
            };

            decoration = {
              rounding = 8;
              drop_shadow = true;
              shadow_ignore_window = true;
              shadow_offset = "0 5";
              shadow_range = 50;
              shadow_render_power = 3;
              "col.shadow" = shadowColorRgba;
              inactive_opacity = 0.8;
              dim_inactive = true;
              dim_strength = 0.1;
            };

            # See https://wiki.hyprland.org/Configuring/Animations/ for more
            animation = [
              "border, 1, 2, default"
              "fade, 1, 4, default"
              "windows, 1, 3, default, popin 80%"
              "workspaces, 1, 2, default, slide"
            ];

          };

        };
      };

      home = {

        pointerCursor = {
          gtk.enable = true;
          # x11.enable = true;
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Classic";
          size = 16;
        };

        # file."tokyonight01-right.png" = {
        #   source = ./wallpapers/tokyonight01-right.png;
        #   target = ".config/hypr/wallpapers/tokyonight01-right.png";
        # };

        file."wallpaper.png" = {
          source = "${user-settings.user.wallpaper}";
          target = ".config/hypr/wallpapers/wallpaper.png";
        };

      };

      # gtk = {
      #   enable = true;

      #   theme = {
      #     package = pkgs.flat-remix-gtk;
      #     name = "Flat-Remix-GTK-Grey-Darkest";
      #   };

      #   iconTheme = {
      #     package = pkgs.adwaita-icon-theme;
      #     name = "Adwaita";
      #   };

      # };
    };
  };
}
