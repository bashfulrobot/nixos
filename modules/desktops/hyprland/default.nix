# https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/
# impliment scripts: https://github.com/anotherhadi/nixy/blob/3c2157260d27371419906f937e3f159c84b24e7e/home/scripts/brightness/default.nix
{ user-settings, pkgs, config, lib, inputs, ... }:
let
  cfg = config.desktops.hyprland;

  mesa-pkgs-unstable =
    inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};

in {
  options = {
    desktops.hyprland.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Hyprlamd.";
    };
  };

  config = lib.mkIf cfg.enable {

    desktops.hyprland = {
      env.enable = true;
      waybar.enable = true;
      wofi.enable = true;
      sddm.enable = true;
      dbus.enable = true;
      hypridle.enable = true;
      hyprlock.enable = true;
      mako.enable = true;
    };

    apps = {
      epiphany.enable = true;
      nautilus.enable = true;
    };

    sys = {
      stylix.enable = true;
      scripts = {
        screenshots.enable = true;
        get_wm_class.enable = true;
      };
    };

    programs.hyprland = {
      enable = true;
      # set the flake package
      package =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # make sure to also set the portal package, so that they are in sync
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
    };
    # Optional, hint electron apps to use wayland:
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    # I have ssh-agent running in my ssh-module, and addToAgent in my .ssh/config.
    # Not working yet on login

    services = {
      dbus.enable = true;
      gnome.gnome-keyring.enable = true;
      xserver = { excludePackages = [ pkgs.xterm ]; };
    };

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    # If you start experiencing lag and FPS drops in games or programs like Blender on stable NixOS when using the Hyprland flake, it is most likely a mesa version mismatch between your system and Hyprland. You can fix this issue by using mesa from Hyprland’s nixpkgs input:
    hardware.graphics = {
      enable = true;
      package = mesa-pkgs-unstable.mesa.drivers;

      # if you also want 32-bit support (e.g for Steam)
      enable32Bit = true;
      package32 = mesa-pkgs-unstable.pkgsi686Linux.mesa.drivers;
    };

    security = {
      rtkit.enable = true;
      pam.services = {
        login.enableGnomeKeyring = true;
        sddm.enableGnomeKeyring = true;
      };
    };

    environment.systemPackages = with pkgs; [
      inputs.hyprswitch.packages.x86_64-linux.default # hyprswitch
      wl-clipboard
      seahorse # Gnome Keyring
      hyprshot # screenshots
      satty # annotation - screenshots
      brightnessctl
      playerctl
      # wpctl # Provided by the wireplumber package in modules/hw/audio/default.nix
      # blueman # Bluetooth Manager # Provided by the bluetooth package in modules/hw/bluetooth/default.nix
      #pamixer
      pavucontrol # select sound output
    ];

    home-manager.users."${user-settings.user.username}" = {

      home.file."bluetooth.desktop" = {
        source = ./src/bluetooth.desktop;
        target = ".local/share/applications/bluetooth.desktop";
      };

      home.file."sound.desktop" = {
        source = ./src/sound.desktop;
        target = ".local/share/applications/sound.desktop";
      };

      # Remove buttons, do not use them. Makes my theme look better.
      dconf.settings = with inputs.home-manager.lib.hm.gvariant; {
        "org/gnome/desktop/wm/preferences" = { button-layout = ""; };
      };

      wayland.windowManager.hyprland = {
        enable = true;
        systemd.variables = [ "--all" ];

        plugins = [
          # inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprfocus
          #          inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
        ];

        settings = {

          ### --- Variables

          "$mod" = "SUPER";

          ### --- Autostart

          exec-once = [ "waybar" "hyprswitch init &" ];

          ### --- Keyboard bindings

          bind = [

            # Run launcher
            "$mod, Space, exec, wofi"
            #" $mod, Space, exec, wofi --show drun --insensitive --allow-images"

            # window
            "$mod, Q, killactive, "
            "$mod, F, fullscreen,"
            "$mod, L, exec, hyprlock"
            # "ALT,Tab,cyclenext"
            # "ALT,Tab,bringactivetotop"
            "ALT, Tab, exec, hyprswitch simple -s"
            "ALT SHIFT, Tab, exec, hyprswitch simple -s -r"

            # Tiling
            "$mod SHIFT, F, togglefloating,"
            "$mod, P, pseudo,"
            "$mod, J, togglesplit,"

            # Move focus
            "$mod, left, movefocus, l"
            "$mod, right, movefocus, r"
            "$mod, up, movefocus, u"
            "$mod, down, movefocus, d"

            # Run apps
            "$mod, B, exec, google-chrome-stable"
            "$mod, E, exec, code"
            "$mod, Return, exec, alacritty"

            # Screenshots
            # Annotate script here: modules/sys/scripts/screenshot
            # ", Print, exec, grimblast copy area"
            # "$mod, K, exec, hyprshot --mode window"
            "CTRL ALT, P, exec, hyprshot --mode region"
            "CTRL ALT, A, exec, /etc/profiles/per-user/dustin/bin/screenshot-annotate.sh"

            # Example special workspace (scratchpad)
            "$mod, S, togglespecialworkspace, magic"
            "$mod SHIFT, S, movetoworkspace, special:magic"

            # Scroll through existing workspaces
            "$mod, mouse_down, workspace, e+1"
            "$mod, mouse_up, workspace, e-1"

            # Screen brightness
            " , XF86MonBrightnessUp, exec, brightnessctl s +5%"
            " , XF86MonBrightnessDown, exec, brightnessctl s 5%-"

            # Volume and Media Control
            # " , XF86AudioRaiseVolume, exec, pamixer -i 5 "
            # " , XF86AudioLowerVolume, exec, pamixer -d 5 "
            # " , XF86AudioMicMute, exec, pamixer --default-source -m"
            # " , XF86AudioMute, exec, pamixer -t"
            " , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
            " , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
            " , XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 1"
            " , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            " , XF86AudioPlay, exec, playerctl play-pause"
            " , XF86AudioPause, exec, playerctl play-pause"
            " , XF86AudioNext, exec, playerctl next"
            " , XF86AudioPrev, exec, playerctl previous"

          ] ++ (
            # workspaces
            # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
            builtins.concatLists (builtins.genList (x:
              let
                ws = let c = (x + 1) / 10;
                in builtins.toString (x + 1 - (c * 10));
              in [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]) 10));

          ### --- Mouse Bindings

          bindm = [
            # Move/resize windows LMB/RMB
            "bindm = $mod, mouse:272, movewindow"
            "bindm = $mod, mouse:273, resizewindow"
          ];

          bindl = [
            ",XF86AudioMute, exec, sound-toggle" # Toggle Mute
            ",switch:Lid Switch, exec, hyprlock" # Lock when closing Lid
          ];

          ### --- Input

          input = {
            kb_layout = "us";
            kb_variant = "";
            kb_model = "";
            kb_options = "";
            kb_rules = "";

            follow_mouse = 1;

            touchpad = {
              natural_scroll = false;
              disable_while_typing = true;
              scroll_factor = 0.8;
            };

            sensitivity = 0;
          };

          ### --- Gestures

          gestures = {
            workspace_swipe = true;
            workspace_swipe_fingers = 3;
          };

          ### --- Layouts

          dwindle = {
            pseudotile = true;
            preserve_split = true;
          };

          ### --- Visuals

          env = [ "XCURSOR_SIZE, 24" ];

          animations = {
            enabled = true;
            bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
            animation = [
              "windows, 1, 7, myBezier"
              "windowsOut, 1, 7, default, popin 80%"
              "border, 1, 10, default"
              "borderangle, 1, 8, default"
              "fade, 1, 7, default"
              "workspaces, 1, 6, default"
            ];
          };

          general = {
            gaps_in = 5;
            gaps_out = 7;
            border_size = 2;
            resize_on_border = true;
            layout = "dwindle";

            allow_tearing = false;
          };

          decoration = {
            rounding = 6;

            blur = {
              enabled = true;
              size = 3;
              passes = 1;
            };

            drop_shadow = true;
            shadow_range = 4;
            shadow_render_power = 3;
          };

          ### --- Plugin Config

          plugin = {
            # hyprexpo = {
            #   columns = 3;
            #   gap_size = 5;
            #   # bg_col = rgb (111111);
            #   workspace_method =
            #     "center current"; # [center/first] [workspace] e.g. first 1 or center m+1
            #
            #   enable_gesture = true; # laptop touchpad, 4 fingers
            #   gesture_distance = 300; # how far is the "max"
            #   gesture_positive =
            #     true; # positive = swipe down. Negative = swipe up.
            # };
          };

          ### --- Monitors

          # monitor = [
          #   "Main, 1920x1080@60, 0x0, 1"
          #   "Secondary, 1920x1080@60, auto ,1" # for random monitors
          # ];

          ### --- Window Rules

          windowrule = [
            # "workspace 1      , title:Terminal"
            # "workspace 2      , title:Web"
            # "workspace 3      , title:Development"
            # "workspace 4      , title:Chat"
            # "workspace 8      , title:Steam"
            # "workspace 10     , title:passwordManager"

            # "noblur,^(?!(rofi))"

            "center,^(wofi)$"
            "center,com.gabm.satty"
            "float,com.gabm.satty"
            # "noborder,^(wofi)$"
          ];

          windowrulev2 = [ "suppressevent maximize, class:.*" ];

        };
      };

    };
  };
}
