{ user-settings, pkgs, secrets, config, lib, ... }:
let
  cfg = config.cli.foot;

  footIcon = pkgs.fetchurl {
    url =
      "https://codeberg.org/dnkl/foot/src/branch/master/icons/hicolor/scalable/apps/foot.svg";
    sha256 =
      "0765nz2qkg2ac0adyvqlh0sir3xsja0hqpy5h8hsmpgzmlirxl05"; # Replace with actual hash
  };

  footDesktopItem = pkgs.makeDesktopItem {
    name = "foot";
    desktopName = "Foot Terminal";
    exec = "${pkgs.foot}/bin/foot";
    icon = footIcon;
    comment = "A fast, lightweight and minimalistic Wayland terminal emulator";
    categories = [ "System" "TerminalEmulator" ];
  };

  footPackage = pkgs.stdenv.mkDerivation {
    name = "foot-package";
    srcs = [ footDesktopItem ];
    installPhase = ''
      mkdir -p $out/share/applications
      cp ${footDesktopItem}/share/applications/foot.desktop $out/share/applications/foot.desktop
      mkdir -p $out/share/icons/hicolor/scalable/apps
      cp ${footIcon} $out/share/icons/hicolor/scalable/apps/foot.svg
    '';
  };

in {
  options = {
    cli.foot.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable foot terminal.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ footPackage ];

    home-manager.users."${user-settings.user.username}" = {
      programs.foot = {
        enable = true;
        server.enable = true;
        settings = {
          main = {
            shell = "${pkgs.fish}/bin/fish";
            # set in stylix
            # font =
              # "Fira Code:size=12, Font Awesome 6 Free :size=12, Font Awesome 6 Free Regular:size=12, Font Awesome 6 Free Solid:size=12, Font Awesome 6 Brands:size=12";
            letter-spacing = "1";
            box-drawings-uses-font-glyphs = "no";
            pad = "12x12";
            # set in stylix
            # dpi-aware = "yes";
            selection-target = "both";
          };

          scrollback = {
            lines = 10000;
            multiplier = 3;
          };

          mouse = { hide-when-typing = "yes"; };

          key-bindings = {
            clipboard-copy = "Control+Shift+c";
            clipboard-paste = "Control+Shift+v Control+y";
            primary-paste = "Shift+Insert";
          };

          csd = {
            # border-width = 1;
            # border-color = "1A1B26";
            preferred = "none";
          };

          # set in stylix
          # colors.alpha = 0.9;
          cursor.color = "1A1826 C0CAF5";
          colors = {
            foreground = "C0CAF5";
            background = "1A1B26";
            regular0 = "414868";
            regular1 = "F7768E";
            regular2 = "9ECE6A";
            regular3 = "E0AF68";
            regular4 = "7AA2F7";
            regular5 = "BB9AF7";
            regular6 = "7DCFFF";
            regular7 = "C0CAF5";
            bright0 = "565F89";
            bright1 = "F7768E";
            bright2 = "9ECE6A";
            bright3 = "E0AF68";
            bright4 = "7AA2F7";
            bright5 = "BB9AF7";
            bright6 = "7DCFFF";
            bright7 = "C0CAF5";
          };
        };
      };
    };
  };
}
