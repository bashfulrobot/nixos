{ user-settings, pkgs, secrets, config, lib, ... }:
let
  cfg = config.cli.foot;
  footDesktopFile = pkgs.writeTextFile {
    name = "foot.desktop";
    text = ''
      [Desktop Entry]
      Version=1.0
      Name=Foot Terminal
      Comment=A fast, lightweight and minimalistic Wayland terminal emulator
      Exec=${pkgs.foot}/bin/foot
      Icon=${pkgs.foot}/share/icons/hicolor/48x48/apps/foot.png
      Terminal=false
      Type=Application
      Categories=System;TerminalEmulator;
    '';
    installPhase = ''
      mkdir -p $out/share/applications
      cp $src $out/share/applications/foot.desktop
    '';
  };
  footIcon = pkgs.stdenv.mkDerivation {
    name = "foot-icon";
    src = ./foot.png;
    installPhase = ''
      mkdir -p $out/share/icons/hicolor/48x48/apps
      cp $src $out/share/icons/hicolor/48x48/apps/foot.png
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
    environment.systemPackages = with pkgs; [ footDesktopFile footIcon ];

    home-manager.users."${user-settings.user.username}" = {

      programs.foot = {
        enable = true;
        # server.enable = true;
        settings = {
          main = {
            shell = "${pkgs.fish}/bin/fish";
            font =
              "Fira Code:size=12, Font Awesome 6 Free :size=12, Font Awesome 6 Free Regular:size=12, Font Awesome 6 Free Solid:size=12, Font Awesome 6 Brands:size=12";
            # font = "Victor Mono:size=12, Font Awesome 6 Free :size=12, Font Awesome 6 Free Regular:size=12, Font Awesome 6 Free Solid:size=12, Font Awesome 6 Brands:size=12";

            # font = "Code OnePiece:size=26, Noto Color Emoji:size=25";
            # font-bold = "Code OnePiece:size=26, Noto Color Emoji:size=25";
            letter-spacing = "1";
            box-drawings-uses-font-glyphs = "no";
            pad = "12x12";
            # pad = "0x0center";
            dpi-aware = "yes";
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

        };
      };

    };
  };
}
