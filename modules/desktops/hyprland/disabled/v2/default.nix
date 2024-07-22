# https://github.com/hyprland-community/awesome-hyprland
# https://github.com/notusknot/dotfiles-nix
{ user-settings, pkgs, config, lib, inputs, ... }:
let cfg = config.desktops.hyprland;
in {
  options = {
    desktops.hyprland.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable hyprland Desktop";
    };
    desktops.hyprland.laptop = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Indicate if the system is a laptop";
    };
  };

  config = lib.mkIf cfg.enable {

    users = lib.mkMerge [
      (lib.mkIf cfg.laptop {
        users."${user-settings.user.username}".extraGroups = [ "video" ];
      })
    ];

    cli = {
      foot.enable = true;
      yazi.enable = true;
    };

    desktops.hyprland = {
      dunst.enable = true;
      eww.enable = true;
      wofi.enable = true;
      xdg.enable = true;
    };

    services = {

      # Configure keymap in X11
      xserver = {
        enable = true;
        xkb = {
          layout = "us";
          variant = "";
        };
      };
    };
    fonts = {
      packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        font-awesome
        source-han-sans
        work-sans
      ];
      fontconfig.defaultFonts = {
        serif = [ "Work Sans" "Noto Serif" "Source Han Serif" ];
        sansSerif = [ "Work Sans" "Noto Sans" "Source Han Sans" ];
      };
    };

    environment = {

      sessionVariables = { NIXOS_OZONE_WLR = "1"; };

      variables = {
        XDG_DATA_HOME = "$HOME/.local/share";
        GTK_RC_FILES = "$HOME/.local/share/gtk-1.0/gtkrc";
        GTK2_RC_FILES = "$HOME/.local/share/gtk-2.0/gtkrc";
        MOZ_ENABLE_WAYLAND = "1";
        EDITOR = "nvim";
        DIRENV_LOG_FORMAT = "";
        ANKI_WAYLAND = "1";
        DISABLE_QT5_COMPAT = "0";
      };

      systemPackages = with pkgs; [
        wofi
        swaybg
        wlsunset
        wl-clipboard
        hyprland
        ripgrep
        ffmpeg
        tealdeer
        exa
        htop
        fzf
        gnupg
        bat
        unzip
        lowdown
        zk
        grim
        slurp
        slop
        imagemagick
        age
        libnotify
        git
        python3
        lua
        zig
        mpv
        firefox
        pqiv
        wf-recorder
        anki-bin
      ];
    };

    xdg = {
      portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-wlr
          xdg-desktop-portal-gtk
        ];
        gtkUsePortal = true;
      };
    };

    ##### Home Manager Config options #####
    home-manager.users."${user-settings.user.username}" = {
      home.file.".config/hypr/hyprland.conf".source =
        ./build/cfg/hyprland/hyprland.conf;
    };
  };
}
