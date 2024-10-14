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
        work-sans
        ];
      home.file."bender-c3pio-daft-punk.png" = {
        source = ../../../../sys/stylix/wallpapers/bender-c3pio-daft-punk.png;
        target = ".local/share/backgrounds/bender-c3pio-daft-punk.png";
      };

# window excetpions
      home.file.".config/pop-shell/config.json".text = ''
{
  "float": [
    {
      "class": "pop-shell-example",
      "title": "pop-shell-example"
    },
    {
      "class": "firefox",
      "title": "^(?!.*Mozilla Firefox).*$",
      "disabled": true
    },
    {
      "class": "zoom",
      "disabled": false
    },
    {
      "class": "Slack",
      "disabled": false
    },
    {
      "class": "Element",
      "disabled": false
    },
    {
      "class": "1Password",
      "disabled": false
    },
    {
      "class": "chrome-chat.developer.gov.bc.ca__channel_devops-sysdig-Default",
      "disabled": false
    }

  ],
  "skiptaskbarhidden": [],
  "log_on_focus": false
}

      '';

      dconf.settings = with inputs.home-manager.lib.hm.gvariant; {

        "org/gnome/desktop/interface" = {
          # Disable (fonts) when using Stylix
          font-name = "Work Sans 12";
          document-font-name = "Work Sans 12";
          monospace-font-name = "Source Code Pro 10";
          font-hinting = "full";
          font-antialiasing = "rgba";
        };
        "org/gnome/desktop/wm/preferences" = {
          # button-layout = "appmenu:minimize,maximize,close";
          # button-layout = "";
          num-workspaces = 4;

        };

        # "org/gnome/desktop/sound" = { theme-name = "tokyonight-gtk-theme"; };

        # Disable when using Stylix
        "org/gnome/desktop/background" = {
          picture-uri =
            "file:///home/dustin/.local/share/backgrounds/bender-c3pio-daft-punk.png";
          picture-uri-dark =
            "file:///home/dustin/.local/share/backgrounds/bender-c3pio-daft-punk.png";
          color-shading-type = "solid";
          picture-options = "zoom";
          primary-color = "#000000";
          secondary-color = "#000000";
        };

        "org/gnome/desktop/screensaver" = {
          picture-uri =
            "file:///home/dustin/.local/share/backgrounds/bender-c3pio-daft-punk.png";
          # color-shading-type = "solid";
          picture-options = "zoom";
          # primary-color = "#000000";
          # secondary-color = "#000000";
        };

        "org/gnome/shell/extensions/pop-shell" = {
          active-hint = false;
          hint-color-rgba = "rgb(122, 162, 247)";
          # gaps need to be the same.
          gap-inner = mkUint32 4;
          gap-outer = mkUint32 4;
          smart-gaps = false;
          active-hint-border-radius = mkUint32 0;
          show-title = false;
          show-skip-taskbar = false;
        };
      };

    };

  };
}
