{ user-settings, pkgs, config, lib, inputs, ... }:

let cfg = config.desktops.gnome.themes.visuals;

in {
  options = {
    desktops.gnome.themes.visuals.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Gnome Visual Settings.";
    };
  };

  config = lib.mkIf cfg.enable {

    home-manager.users."${user-settings.user.username}" = {
      # Getting yaru cursor, sound and icon themes
      home.packages = with pkgs; [ 
        # tokyonight-gtk-theme 
        work-sans
        ];
      # https://github.com/kevin-nel/tokyo-night-gtksourceview
      # home.file."tokyo-night.xml" = {
      #   source = ./config/tokyo-night.xml;
      #   target = ".local/share/gtksourceview-5/styles/tokyo-night.xml";
      # };
      home.file."trees.png" = {
        source = ../../../../sys/stylix/wallpapers/trees.png;
        target = ".local/share/backgrounds/trees.png";
      };

      dconf.settings = with inputs.home-manager.lib.hm.gvariant; {

        "org/gnome/desktop/interface" = {
          # set in stylix
          # document-font-name = "Work Sans 12";
          font-name = "Work Sans 12";
          # set in stylix
          # monospace-font-name = "Victor Mono 13";
          # set in stylix
          # cursor-theme = "Adwaita";
          # set in stylix
          # gtk-theme = "Tokyonight-Dark";
          # icon-theme = "Tokyonight-Dark";
        };
        "org/gnome/extensions/appindicator" = {
          # icon-saturation = 0.9999999999999999;

        };

        "org/gnome/desktop/wm/preferences" = {
          # button-layout = "appmenu:minimize,maximize,close";
          # button-layout = "";
          num-workspaces = 4;
          # theme = "Tokyonight-Dark";

        };

        # "org/gnome/desktop/sound" = { theme-name = "tokyonight-gtk-theme"; };

        "org/gnome/desktop/background" = {
          # Disabled and set in stylix
          # picture-uri =
          #   "file:///home/dustin/.local/share/backgrounds/trees.png";
          # picture-uri-dark =
          #   "file:///home/dustin/.local/share/backgrounds/trees.png";
          # color-shading-type = "solid";
          # picture-options = "zoom";
          # primary-color = "#000000";
          # secondary-color = "#000000";
        };

        "org/gnome/desktop/screensaver" = {
          picture-uri =
            "file:///home/dustin/.local/share/backgrounds/trees.png";
          # color-shading-type = "solid";
          picture-options = "zoom";
          # primary-color = "#000000";
          # secondary-color = "#000000";
        };

        "org/gnome/shell/extensions/pop-shell" = {
          active-hint = false;
          # hint-color-rgba = "rgb(122, 162, 247)";
          gap-inner = 10;
          gap-outer = 10;
          active-hint-border-radius = 10;
          show-title = false;
          show-skip-taskbar = false;
        };
      };

    };

  };
}
