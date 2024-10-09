# https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/
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

    environment.systemPackages = with pkgs; [ ];

    desktops.hyprland = {
      waybar.enable = true;
      wofi.enable = true;
      sddm.enable = true;
      dbus.enable = true;
    };

    sys.stylix.enable = true;

    home-manager.users."${user-settings.user.username}" = {

      wayland.windowManager.hyprland = {
        enable = true;
        systemd.variables = [ "--all" ];

        settings = {

          ### --- Variables

          "$mod" = "SUPER";

          ### --- Autostart

          exec-once = [ "waybar" ];

          ### --- Keyboard bindings

          bind = [

            # Run launcher
            "$mod, Space, exec, wofi --show drun --insensitive --allow-images"

            # Close window
            "$mod, Q, killactive, "

            # Tiling
            "$mod, V, togglefloating,"
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
            "$mod, T, exec, alacritty"

            # Screenshots
            # ", Print, exec, grimblast copy area"
            # "$mod, K, exec, hyprshot --mode window"
            # "$mod, H, exec, hyprshot --mode region"

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
            " , XF86AudioRaiseVolume, exec, pamixer -i 5 "
            " , XF86AudioLowerVolume, exec, pamixer -d 5 "
            " , XF86AudioMicMute, exec, pamixer --default-source -m"
            " , XF86AudioMute, exec, pamixer -t"
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

          ### --- Input

          input = {
            kb_layout = "us";
            kb_variant = "";
            kb_model = "";
            kb_options = "";
            kb_rules = "";

            follow_mouse = 1;

            touchpad = { natural_scroll = true; };

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

            layout = "dwindle";

            allow_tearing = false;
          };

          decoration = {
            rounding = 3;

            blur = {
              enabled = true;
              size = 3;
              passes = 1;
            };

            drop_shadow = true;
            shadow_range = 4;
            shadow_render_power = 3;
          };

          ### --- Monitors

          # monitor = [
          #   "Main, 1920x1080@60, 0x0, 1"
          #   "Secondary, 1920x1080@60, auto ,1" # for random monitors
          # ];

        };
      };

    };
  };
}
