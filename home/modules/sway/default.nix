{ pkgs, config, inputs, ... }: {

  imports = [
    ./mako
    ./rofi
    ./swappy
    ./waybar
    # ./wpaperd
    # ./sway-alttab
  ];

  home.file.".config/sway/config".text = ''

    ### Variables
    #

    # Complete Gruvbox Dark soft color scheme
    set $gruvbox-bg "#32302f"
    set $gruvbox-bg1 "#3c3836"
    set $gruvbox-bg2 "#504945"
    set $gruvbox-bg3 "#665c54"
    set $gruvbox-bg4 "#7c6f64"

    set $gruvbox-fg "#d4be98"
    set $gruvbox-fg1 "#ddc7a1"

    set $gruvbox-red "#ea6962"
    set $gruvbox-red1 "#d65d75"

    set $gruvbox-green "#a9b665"
    set $gruvbox-green1 "#afbe8c"

    set $gruvbox-yellow "#d8a657"
    set $gruvbox-yellow1 "#e3b86b"

    set $gruvbox-blue "#7daea3"
    set $gruvbox-blue1 "#89b482"

    set $gruvbox-magenta "#d3869b"
    set $gruvbox-magenta1 "#e0abc4"

    set $gruvbox-cyan "#89b482"
    set $gruvbox-cyan1 "#a2bdb9"

    set $gruvbox-orange "#e78a4e"
    set $gruvbox-orange1 "#f2a878"

    # Logo key. Use Mod1 for Alt.
    set $mod Mod4

    # Home row direction keys, like vim
    set $left h
    set $down j
    set $up k
    set $right l

    # Your preferred terminal emulator
    set $term alacritty

    # Your preferred application launcher
    set $menu "rofi -combi-modi drun,run -show combi"

    # lock command for keyboard shortcut
    set $lockman exec bash /etc/profiles/per-user/dustin/bin/lockman

    # lock command for swayidle
    set $lock swaylock --screenshots --clock --indicator --indicator-radius 100 --indicator-thickness 7 --effect-blur 7x5 --effect-vignette 0.5:0.5 --ring-color d3869b --key-hl-color fabd2f --line-color 3c3836 --inside-color 282828 --separator-color 3c3836 --grace 2 --fade-in 0.2

    ### Autostart Applications
    #

    exec dbus-sway-environment
    exec configure-gtk
    exec_always --no-startup-id 1password
    # exec nm-applet --indicator
    # exec pasystray --notify=all -S
    # exec blueman-applet

    ### Visuals
    #

    # Set Wallpaper with wpaperd
    # exec wpaperd # wallpaper
    # Set Wallpaper
    output * bg /home/dustin/Pictures/Wallpapers/gruvbox-wallpapers/wallpapers/mix/dead-robot.jpg fill

    # Set the window borders
    default_border pixel 2
    default_floating_border pixel 2
    # Configurations for window borders and title bars
    client.focused $gruvbox-blue $gruvbox-bg $gruvbox-fg $gruvbox-green $gruvbox-yellow
    client.focused_inactive $gruvbox-bg $gruvbox-bg $gruvbox-fg
    client.focused_tab_title $gruvbox-bg $gruvbox-bg $gruvbox-fg
    client.unfocused $gruvbox-bg $gruvbox-bg $gruvbox-fg
    client.urgent $gruvbox-red $gruvbox-bg $gruvbox-fg

    # Swayfx settings:
    # corner_radius 10

    ### Hardware
    #

    # Trackpad Settings
    input type:touchpad {
    tap enabled
    natural_scroll disabled
    }

    # Example configuration:
    #
    # You can get the names of your inputs by running: swaymsg -t get_inputs

    #   input "2:14:SynPS/2_Synaptics_TouchPad" {
    #       dwt enabled
    #       tap enabled
    #       natural_scroll enabled
    #       middle_emulation enabled
    #   }

    # Mouse Settings
    focus_follows_mouse no

    ### Window Rules
    #
    # Can get class with: swaymsg -t get_tree

    # Always put 1pass on ws10
    # assign [class="1Password"] 10

    ### Window Behavior
    #

    # Swayr Settings
    # bindsym $mod+Space       exec swayr switch-window
    # bindsym $mod+Delete      exec swayr quit-window
    # bindsym $mod+Tab         exec swayr switch-to-urgent-or-lru-window
    # bindsym $mod+Next        exec swayr next-window all-workspaces
    # bindsym $mod+Prior       exec swayr prev-window all-workspaces
    # bindsym $mod+Shift+Space exec swayr switch-workspace-or-window
    # bindsym $mod+c           exec swayr execute-swaymsg-command
    # bindsym $mod+Tab+c     exec swayr execute-swayr-command

    ### Monitor Configuration
    #

    # Example configuration:    #
    #   output HDMI-A-1 resolution 1920x1080 position 1920,0
    #
    # You can get the names of your outputs by running: swaymsg -t get_outputs

    ### Idle configuration
    #

    exec swayidle -w \
      timeout 300 $lock \
      timeout 600 'swaymsg "output * power off"' \
      resume 'swaymsg "output * power on"' \
      before-sleep $lock

    ### Key bindings
    #

    # Emulate a form of alt tab
    bindsym Alt+Tab exec rofi -show window

    # lock my screen
    bindsym $mod+Alt+l exec $lockman

    # Take Screenshots
    bindsym Ctrl+Alt+p exec grim -g "$(slurp)" - | swappy -f -
    bindsym Print exec grim -g "$(slurp)" - | swappy -f - # laptop

    # Keyboard brightness
    bindsym XF86MonBrightnessDown exec brightnessctl set 5%-
    bindsym XF86MonBrightnessUp exec brightnessctl set 5%+

    # Volume Control
    bindsym XF86AudioRaiseVolume exec 'pactl set-sink-volume @DEFAULT_SINK@ +1%'
    bindsym XF86AudioLowerVolume exec 'pactl set-sink-volume @DEFAULT_SINK@ -1%'
    bindsym XF86AudioMute exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle'
    bindsym XF86AudioMicMute exec pactl set-source-mute @DEFAULT_SOURCE@ toggle

    # Media keys
    bindsym --locked XF86AudioPlay exec playerctl play-pause
    bindsym --locked XF86AudioNext exec playerctl next
    bindsym --locked XF86AudioPrev exec playerctl previous

    # Start a terminal
    bindsym $mod+Return exec $term
    bindsym $mod+t exec $term

    # Kill focused window
    bindsym $mod+q kill

    # Start your launcher
    bindsym $mod+Space exec $menu

    # Start 1Password Quick Access
    bindsym Control+Shift+Space exec 1password --quick-access

    # Drag floating windows by holding down $mod and left mouse button.
    # Resize them with right mouse button + $mod.
    # Despite the name, also works for non-floating windows.
    # Change normal to inverse to use left mouse button for resizing and right
    # mouse button for dragging.
    floating_modifier $mod normal

    # Reload the configuration file
    bindsym $mod+Shift+c reload

    # Exit sway (logs you out of your Wayland session)
    bindsym $mod+Shift+e exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit'

    # Move your focus around
    bindsym $mod+$left focus left
    bindsym $mod+$down focus down
    bindsym $mod+$up focus up
    bindsym $mod+$right focus right
    # Or use $mod+[up|down|left|right]
    bindsym $mod+Left focus left
    bindsym $mod+Down focus down
    bindsym $mod+Up focus up
    bindsym $mod+Right focus right

    # Move the focused window with the same, but add Shift
    bindsym $mod+Shift+$left move left
    bindsym $mod+Shift+$down move down
    bindsym $mod+Shift+$up move up
    bindsym $mod+Shift+$right move right
    # Ditto, with arrow keys
    bindsym $mod+Shift+Left move left
    bindsym $mod+Shift+Down move down
    bindsym $mod+Shift+Up move up
    bindsym $mod+Shift+Right move right

    # Switch to workspace
    bindsym $mod+1 workspace number 1
    bindsym $mod+2 workspace number 2
    bindsym $mod+3 workspace number 3
    bindsym $mod+4 workspace number 4
    bindsym $mod+5 workspace number 5
    bindsym $mod+6 workspace number 6
    bindsym $mod+7 workspace number 7
    bindsym $mod+8 workspace number 8
    bindsym $mod+9 workspace number 9
    bindsym $mod+0 workspace number 10
    # Move focused container to workspace
    bindsym $mod+Shift+1 move container to workspace number 1
    bindsym $mod+Shift+2 move container to workspace number 2
    bindsym $mod+Shift+3 move container to workspace number 3
    bindsym $mod+Shift+4 move container to workspace number 4
    bindsym $mod+Shift+5 move container to workspace number 5
    bindsym $mod+Shift+6 move container to workspace number 6
    bindsym $mod+Shift+7 move container to workspace number 7
    bindsym $mod+Shift+8 move container to workspace number 8
    bindsym $mod+Shift+9 move container to workspace number 9
    bindsym $mod+Shift+0 move container to workspace number 10
    # Note: workspaces can have any name you want, not just numbers.
    # We just use 1-10 as the default.

    # You can "split" the current object of your focus with
    # $mod+b or $mod+v, for horizontal and vertical splits
    # respectively.
    bindsym $mod+b splith
    bindsym $mod+v splitv

    # Switch the current container between different layout styles
    bindsym $mod+s layout stacking
    bindsym $mod+w layout tabbed
    bindsym $mod+e layout toggle split

    # Make the current focus fullscreen
    bindsym $mod+f fullscreen

    # Toggle the current focus between tiling and floating mode
    bindsym $mod+Shift+space floating toggle

    # Swap focus between the tiling area and the floating area
    # bindsym $mod+space focus mode_toggle

    # Move focus to the parent container
    bindsym $mod+a focus parent

    # Sway has a "scratchpad", which is a bag of holding for windows.
    # You can send windows there and get them back later.

    # Move the currently focused window to the scratchpad
    bindsym $mod+Shift+minus move scratchpad

    # Show the next scratchpad window or hide the focused scratchpad window.
    # If there are multiple scratchpad windows, this command cycles through them.
    bindsym $mod+minus scratchpad show

    # Resizing containers:
    mode "resize" {
        # left will shrink the containers width
        # right will grow the containers width
        # up will shrink the containers height
        # down will grow the containers height
        bindsym $left resize shrink width 10px
        bindsym $down resize grow height 10px
        bindsym $up resize shrink height 10px
        bindsym $right resize grow width 10px

        # Ditto, with arrow keys
        bindsym Left resize shrink width 10px
        bindsym Down resize grow height 10px
        bindsym Up resize shrink height 10px
        bindsym Right resize grow width 10px

        # Return to default mode
        bindsym Return mode "default"
        bindsym Escape mode "default"
    }
    bindsym $mod+r mode "resize"

    ### Bar Settings
    #

    bar {
      swaybar_command waybar
      position top
      hidden_state hide
      mode hide
      modifier $mod
      }

    ### Include Addituional Configs
    #

    include /etc/sway/config.d/*

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
