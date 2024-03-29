{ pkgs, config, inputs, ... }: {

  imports = [
    # ./mako
    # ./rofi
    # ./swappy
    # ./swayidle
    # ./waybar
    # ./wpaperd
    # ./sway-alttab
  ];

  home.file.".config/hypr/hyprland.conf".text = ''

    ### Variables
    #

    # Complete Gruvbox Dark soft color scheme
    # set $gruvbox-bg "#32302f"
    # set $gruvbox-bg1 "#3c3836"
    # set $gruvbox-bg2 "#504945"
    # set $gruvbox-bg3 "#665c54"
    # set $gruvbox-bg4 "#7c6f64"

    # set $gruvbox-fg "#d4be98"
    # set $gruvbox-fg1 "#ddc7a1"

    # set $gruvbox-red "#ea6962"
    # set $gruvbox-red1 "#d65d75"

    # set $gruvbox-green "#a9b665"
    # set $gruvbox-green1 "#afbe8c"

    # set $gruvbox-yellow "#d8a657"
    # set $gruvbox-yellow1 "#e3b86b"

    # set $gruvbox-blue "#7daea3"
    # set $gruvbox-blue1 "#89b482"

    # set $gruvbox-magenta "#d3869b"
    # set $gruvbox-magenta1 "#e0abc4"

    # set $gruvbox-cyan "#89b482"
    # set $gruvbox-cyan1 "#a2bdb9"

    # set $gruvbox-orange "#e78a4e"
    # set $gruvbox-orange1 "#f2a878"
    # https://github.com/adtya/nixos-config/blob/main/home/wm/hyprland/default.nix#L21-L23
    # https://github.com/bashfulrobot/nixos-hyprland/blob/main/modules/hyprland/default.nix

    ########################################################################################
    AUTOGENERATED HYPR CONFIG.
    PLEASE USE THE CONFIG PROVIDED IN THE GIT REPO /examples/hypr.conf AND EDIT IT,
    OR EDIT THIS ONE ACCORDING TO THE WIKI INSTRUCTIONS.
    ########################################################################################

    #
    # Please note not all available settings / options are set here.
    # For a full list, see the wiki
    #

    # See https://wiki.hyprland.org/Configuring/Monitors/
    #monitor=,preferred,auto,auto
    #
    # last is scaling. Set to 1
    monitor=,highres,auto,1
    # Mirror monitor below. Get details with `hyprctl monitors`
    # monitor=HDMI-A-1,1920x1200@60,0x0,1,mirror,eDP-1

    # unscale XWayland
    xwayland {
        force_zero_scaling = true
    }

    # toolkit-specific scale
    env = GDK_SCALE,1
    env = QT_AUTO_SCREEN_SCALE_FACTOR.1
    env = XCURSOR_SIZE,32

    env = XDG_CURRENT_DESKTOP,Hyprland
    env = XDG_SESSION_TYPE,wayland
    env = XDG_SESSION_DESKTOP,Hyprland

    env = GDK_BACKEND,wayland
    env = QT_QPA_PLATFORM,wayland
    env = SDL_VIDEODRIVER,wayland

    misc {
        disable_hyprland_logo = true
        disable_splash_rendering = true
        # Screen on when idle
        # mouse_move_enables_dpms = true
        # key_press_enables_dpms = true
    }

    # swayidle
    exec-once = swayidle -w

    # See https://wiki.hyprland.org/Configuring/Keywords/ for more

    # Execute your favorite apps at launch
    # exec-once = waybar & hyprpaper & firefox
    #

    exec-once = waybar

    # Source a file (multi-file configs)
    # source = ~/.config/hypr/myColors.conf

    # Some default env vars.
    env = XCURSOR_SIZE,24

    # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
    input {
        kb_layout = us
        kb_variant =
        kb_model =
        kb_options =
        kb_rules =

        follow_mouse = 2

        touchpad {
            natural_scroll = no
        }

        sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
    }

    general {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        gaps_in = 5
        gaps_out = 15
        border_size = 2
        # col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
        col.active_border = rgba(e0abc4ff) rgba(d3869bff) 45deg
        col.inactive_border = rgba(595959aa)

        layout = dwindle
    }

    decoration {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        rounding = 10

        blur {
            enabled = true
            size = 3
            passes = 1
        }

        drop_shadow = yes
        shadow_range = 4
        shadow_render_power = 3
        col.shadow = rgba(1a1a1aee)
    }

    animations {
        enabled = yes

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = myBezier, 0.05, 0.9, 0.1, 1.05

        animation = windows, 1, 7, myBezier
        animation = windowsOut, 1, 7, default, popin 80%
        animation = border, 1, 10, default
        animation = borderangle, 1, 8, default
        animation = fade, 1, 7, default
        animation = workspaces, 1, 6, default
    }

    dwindle {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = yes # you probably want this
    }

    master {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        new_is_master = true
    }

    gestures {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = off
    }

    # Example per-device config
    # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
    device:epic-mouse-v1 {
        sensitivity = -0.5
    }

    # Example windowrule v1
    # windowrule = float, ^(kitty)$
    # Example windowrule v2
    # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
    # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more

    # See https://wiki.hyprland.org/Configuring/Keywords/ for more
    $mainMod = SUPER

    # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
    bind = $mainMod, T, exec, alacritty
    bind = $mainMod, Q, killactive,
    bind = SUPER_SHIFT, M, exit,
    bind = $mainMod, E, exec, nautilus
    bind = $mainMod, V, togglefloating,
    bind = $mainMod, R, exec, rofi -combi-modi drun,run -show combi
    bind = $mainMod, space, exec, rofi -combi-modi drun,run -show combi
    # windows key only to launch menu
    bindr = SUPER, SUPER_L, exec, rofi -combi-modi drun,run -show combi
    # Lock screen
    bind = $mainMod, L, exec, bash /etc/profiles/per-user/dustin/bin/lockman
    # Fullscreen
    bind = $mainMod, F, fullscreen
    # Maximize
    bind = SUPER_SHIFT, F, fullscreen, 1
    # Screenshots
    bind = CONTROLALT, P, exec, grim -g "$(slurp)" - | swappy -f -
    bind = $mainMod, P, pseudo, # dwindle
    bind = $mainMod, J, togglesplit, # dwindle

    # Toggle waybar visibility
    bind = $mainMod, o, exec, killall -SIGUSR1 .waybar-wrapped

    # emulate alt-tab
    bind = ALT, Tab, exec, rofi -show window

    # Move focus with mainMod + arrow keys
    bind = $mainMod, left, movefocus, l
    bind = $mainMod, right, movefocus, r
    bind = $mainMod, up, movefocus, u
    bind = $mainMod, down, movefocus, d

    # Switch workspaces with mainMod + [0-9]
    bind = $mainMod, 1, workspace, 1
    bind = $mainMod, 2, workspace, 2
    bind = $mainMod, 3, workspace, 3
    bind = $mainMod, 4, workspace, 4
    bind = $mainMod, 5, workspace, 5
    bind = $mainMod, 6, workspace, 6
    bind = $mainMod, 7, workspace, 7
    bind = $mainMod, 8, workspace, 8
    bind = $mainMod, 9, workspace, 9
    bind = $mainMod, 0, workspace, 10

    # Move active window to a workspace with mainMod + SHIFT + [0-9]
    bind = $mainMod SHIFT, 1, movetoworkspace, 1
    bind = $mainMod SHIFT, 2, movetoworkspace, 2
    bind = $mainMod SHIFT, 3, movetoworkspace, 3
    bind = $mainMod SHIFT, 4, movetoworkspace, 4
    bind = $mainMod SHIFT, 5, movetoworkspace, 5
    bind = $mainMod SHIFT, 6, movetoworkspace, 6
    bind = $mainMod SHIFT, 7, movetoworkspace, 7
    bind = $mainMod SHIFT, 8, movetoworkspace, 8
    bind = $mainMod SHIFT, 9, movetoworkspace, 9
    bind = $mainMod SHIFT, 0, movetoworkspace, 10

    # Scroll through existing workspaces with mainMod + scroll
    bind = $mainMod, mouse_down, workspace, e+1
    bind = $mainMod, mouse_up, workspace, e-1

    # Move/resize windows with mainMod + LMB/RMB and dragging
    bindm = $mainMod, mouse:272, movewindow
    bindm = $mainMod, mouse:273, resizewindow

  '';

  ### Gnome-Keyring
  services.gnome-keyring = {
    enable = true;
    components = [ "pkcs11" "secrets" "ssh" ];
  };

  home.packages = with pkgs;
    [
      (writeScriptBin "lockman" ''
        #!/usr/bin/env bash

        # Times the screen off and puts it to background
        swayidle \
            timeout 10 'swaymsg "output * dpms off"' \
            resume 'swaymsg "output * dpms on"' &
        # Locks the screen immediately
        swaylock --screenshots --clock --indicator --indicator-radius 100 --indicator-thickness 7 --effect-blur 7x5 --effect-vignette 0.5:0.5 --ring-color d3869b --key-hl-color fabd2f --line-color 3c3836 --inside-color 282828 --separator-color 3c3836 --grace 2 --fade-in 0.2
        # Kills last background task so idle timer doesn't keep running
        kill %%

        exit 0
      '')
    ];
}
