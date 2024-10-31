{ user-settings, pkgs, config, lib, ... }:
let cfg = config.apps.chrome-based-browser;
in {

  options = {
    apps.chrome-based-browser = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable a chrome based browser.";
      };
      browser = lib.mkOption {
        type = lib.types.enum [ "chromium" "ungoogled-chromium" "brave" "vivaldi" ];
        default = "chromium";
        description = "The browser to use.";
      };
      disableWayland = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Disable Wayland support.";
      };
    };

  };

  config = lib.mkIf cfg.enable {
    home-manager.users."${user-settings.user.username}" = {

      # Conditionally include vivaldi-ffmpeg-codecs
      home.packages =
        lib.optional (cfg.browser == "vivaldi") pkgs.vivaldi-ffmpeg-codecs;

      programs.chromium = {
        enable = true;
        package = if cfg.browser == "chromium" then
          pkgs.chromium
        else if cfg.browser == "ungoogled-chromium" then
          pkgs.ungoogled-chromium
        else if cfg.browser == "vivaldi" then
          pkgs.vivaldi
        else
          pkgs.brave;
        commandLineArgs = [ "--ozone-platform-hint=auto" ];
        extensions = [
          # bookmark search
          {
            id = "cofpegcepiccpobikjoddpmmocficdjj";
          }
          # kagi search
          {
            id = "cdglnehniifkbagbbombnjghhcihifij";
          }
          # 1password
          {
            id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa";
          }
          # dark reader
          {
            id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";
          }
          # ublock origin
          {
            id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
          }
          # tactiq
          {
            id = "fggkaccpbmombhnjkjokndojfgagejfb";
          }
          # okta
          {
            id = "glnpjglilkicbckjpbgcfkogebgllemb";
          }
          # grammarly
          {
            id = "kbfnbcaeplbcioakkpcpgfkobkghlhen";
          }
          # simplify
          {
            id = "pbmlfaiicoikhdbjagjbglnbfcbcojpj";
          }
          # todoist
          {
            id = "jldhpllghnbhlbpcmnajkpdmadaolakh";
          }
          # Loom video recording
          {
            id = "liecbddmkiiihnedobmlmillhodjkdmb";
          }
          # Privacy Badger
          {
            id = "pkehgijcmpdhfbdbbnkijodmdjhbjlgp";
          }
          # Checker Plus for Mail
          {
            id = "oeopbcgkkoapgobdbedcemjljbihmemj";
          }
          # Checker Plus for Cal
          {
            id = "hkhggnncdpfibdhinjiegagmopldibha";
          }
          # Google docs offline
          {
            id = "ghbmnnjooekpmoecnnnilnnbdlolhkhi";
          }
          # Markdown downloader
          {
            id = "pcmpcfapbekmbjjkdalcgopdkipoggdi";
          }
          # obsidian clipper
          {
            id = "mphkdfmipddgfobjhphabphmpdckgfhb";
          }
          # URL/Tab Manager
          {
            id = "egiemoacchfofdhhlfhkdcacgaopncmi";
          }
          # Mail message URL
          {
            id = "bcelhaineggdgbddincjkdmokbbdhgch";
          }
          # Glean browser extension
          {
            id = "cfpdompphcacgpjfbonkdokgjhgabpij";
          }
          # gnome extention plugin
          {
            id = "gphhapmejobijbbhgpjhcjognlahblep";
          }
          # copy to clipboard
          {
            id = "miancenhdlkbmjmhlginhaaepbdnlllc";
          }
          # Speed dial extention
          {
            id = "jpfpebmajhhopeonhlcgidhclcccjcik";
          }
          # Tokyonight
          {
            id = "enpfonmmpgoinjpglildebkaphbhndek";
          }
          # email tracking for work
          {
            id = "pgbdljpkijehgoacbjpolaomhkoffhnl";
          }
          # zoom
          # {
          #   id = "kgjfgplpablkjnlkjmjdecgdpfankdle";
          # }
          # xbrowsersync
          # {
          #   id = "lcbjdhceifofjlpecfpeimnnphbcjgnc";
          # }
          # Catppuccin Mocha theme
          # {
          #   id = "bkkmolkhemgaeaeggcmfbghljjjoofoh";
          # }
          # Catppuccin Frappe theme
          # {
          #   id = "olhelnoplefjdmncknfphenjclimckaf";
          # }
          # Catppuccin Macchiato theme
          # {
          #   id = "cmpdlhmnmjhihmcfnigoememnffkimlk";
          # }
          # Catppuccin Latte theme
          # {
          #   id = "jhjnalhegpceacdhbplhnakmkdliaddd";
          # }
          # tineye
          # {
          #     id = "haebnnbpedcbhciplfhjjkbafijpncjl";
          # }

        ];
      };
      # force brave to use wayland - https://skerit.com/en/make-electron-applications-use-the-wayland-renderer
      home.file = let
        browserConfig = if !cfg.disableWayland then
          if cfg.browser == "chromium" || cfg.browser == "ungoogled-chromium" then {
            ".config/chromium-flags.conf".text = ''
              --enable-features=UseOzonePlatform
              --ozone-platform=wayland
              --enable-features=WaylandWindowDecorations
              --ozone-platform-hint=auto
            '';
            # --force-device-scale-factor=1
          } else if cfg.browser == "brave" then {
            ".config/brave-flags.conf".text = ''
              --enable-features=UseOzonePlatform
              --ozone-platform=wayland
              --enable-features=WaylandWindowDecorations
              --ozone-platform-hint=auto
            '';
            # --force-device-scale-factor=1
          } else if cfg.browser == "vivaldi" then {
            ".config/vivaldi-stable.conf".text = ''
              --enable-features=UseOzonePlatform
              --ozone-platform=wayland
              --enable-features=WaylandWindowDecorations
              --ozone-platform-hint=auto
            '';
            # --force-device-scale-factor=1
          } else
            { }
        else
          { };
      in lib.mkMerge [
        browserConfig
        {
          # Add other home.file configurations here

        }
      ];
    };
  };
}
