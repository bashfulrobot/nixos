# # Keychain set-up

{ user-settings, config, lib, pkgs, ... }:
let
  cfg = config.sys.stylix;
  sf-mono-liga-font = pkgs.callPackage ../fonts/build/sfpro/liga { };

in {
  # imports = [ ./build/dark-reader.nix  ];

  options = {
    sys.stylix.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Stylix.";
    };
  };

  config = lib.mkIf cfg.enable {

    stylix = {
      enable = true;
      image = ./wallpapers/trees.png;
      # one of “stretch”, “fill”, “fit”, “center”, “tile”
      imageScalingMode = "fill";
      polarity = "dark"; # or "light" - forcing dark
      # base16Scheme =
      # "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 32;
      };
      opacity = {
        applications = 1.0;
        terminal = 1.0;
        desktop = 1.0;
        popups = 1.0;
      };
      fonts = {
        sizes = {
          applications = 12;
          terminal = 20;
          desktop = 12;
          popups = 10;
        };
        serif = {
          package = pkgs.work-sans;
          name = "Work Sans";
        };

        sansSerif = {
          package = pkgs.work-sans;
          name = "Work Sans";
        };

        monospace = {
          package = sf-mono-liga-font;
          name = "Liga SFMono Nerd Font";
        };

        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };
      };

    };

    # inherit used with stylix to render the darkreader config
    home-manager.users."${user-settings.user.username}" =
      let inherit (config.lib.stylix.colors) withHashtag;
      in {
        home.file.".config/darkreader/config.json".text =
          let inherit (withHashtag) base00 base05;
          in ''
               {
                "schemeVersion": 2,
                "enabled": true,
                "fetchNews": true,
                "theme": {
            	"mode": 1,
            	"brightness": 100,
            	"contrast": 100,
            	"grayscale": 0,
            	"sepia": 0,
            	"useFont": false,
            	"fontFamily": "Open Sans",
            	"textStroke": 0,
            	"engine": "dynamicTheme",
            	"stylesheet": "",
            	"darkSchemeBackgroundColor": "${base00}",
            	"darkSchemeTextColor": "${base05}",
            	"lightSchemeBackgroundColor": "${base05}",
            	"lightSchemeTextColor": "${base00}",
            	"scrollbarColor": "auto",
            	"selectionColor": "auto",
            	"styleSystemControls": false,
            	"lightColorScheme": "Default",
            	"darkColorScheme": "Default",
            	"immediateModify": false
                },
                "presets": [],
                "customThemes": [],
                "enabledByDefault": true,
                "enabledFor": [],
                "disabledFor": [],
                "changeBrowserTheme": false,
                "syncSettings": false,
                "syncSitesFixes": true,
                "automation": {
            	"enabled": false,
            	"mode": "",
            	"behavior": "OnOff"
                },
                "time": {
            	"activation": "18:00",
            	"deactivation": "9:00"
                },
                "location": {
            	"latitude": null,
            	"longitude": null
                },
                "previewNewDesign": true,
                "enableForPDF": true,
                "enableForProtectedPages": true,
                "enableContextMenus": false,
                "detectDarkTheme": false,
                "displayedNews": [
            	"thanks-2023"
                ]
            }
          '';
      };
  };
}
