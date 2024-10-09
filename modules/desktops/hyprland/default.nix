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

    # Helps with screensharing
    services.dbus.enable = true;
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    # If you start experiencing lag and FPS drops in games or programs like Blender on stable NixOS when using the Hyprland flake, it is most likely a mesa version mismatch between your system and Hyprland. You can fix this issue by using mesa from Hyprland’s nixpkgs input:
    hardware.opengl = {
      package = mesa-pkgs-unstable.mesa.drivers;

      # if you also want 32-bit support (e.g for Steam)
      driSupport32Bit = true;
      package32 = mesa-pkgs-unstable.pkgsi686Linux.mesa.drivers;
    };

    security.rtkit.enable = true;

    environment.systemPackages = with pkgs; [ ];

    desktops.hyprland = {
      waybar.enable = true;
      wofi.enable = true;
    };

    sys.stylix.enable = true;

    home-manager.users."${user-settings.user.username}" = {

      programs.kitty.enable =
        true; # TODO: remove later - required for the default Hyprland confif

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
            "$mod, Space, exec, wofi --show"
            # Close window
            "$mainMod, Q, killactive, "

            # Tiling
            "$mainMod, V, togglefloating,"
            "$mainMod, P, pseudo,"
            "$mainMod, J, togglesplit,"

            # Move focus
            "$mainMod, left, movefocus, l"
            "$mainMod, right, movefocus, r"
            "$mainMod, up, movefocus, u"
            "$mainMod, down, movefocus, d"

            # Run apps
            "$mod, B, exec, google-chrome-stable"
            "$mod, T, exec, alacritty"

            # Screenshots
            # ", Print, exec, grimblast copy area"
            # "$mainMod, K, exec, hyprshot --mode window"
            # "$mainMod, H, exec, hyprshot --mode region"

            # Example special workspace (scratchpad)
            "$mainMod, S, togglespecialworkspace, magic"
            "$mainMod SHIFT, S, movetoworkspace, special:magic"

            # Scroll through existing workspaces
            "$mainMod, mouse_down, workspace, e+1"
            "$mainMod, mouse_up, workspace, e-1"

            # Application manager
            "$mainMod, F, exec, rofi -show drun"

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
            "bindm = $mainMod, mouse:272, movewindow"
            "bindm = $mainMod, mouse:273, resizewindow"
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
          master = { new_is_master = true; };

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
            gaps_in = 3;
            gaps_out = 5;
            border_size = 2;
            "col.active_border" = "rgba(e759ffee) rgba(5a70ffee) 45deg";
            "col.inactive_border" = "rgba(595959aa)";

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

        };
      };

    };
  };
}
