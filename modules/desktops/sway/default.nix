# nix-community/nixpkgs-wayland: Automated, pre-built packages for Wayland (sway/wlroots) tools for NixOS. - https://github.com/nix-community/nixpkgs-wayland?tab=readme-ov-file#sway
{ user-settings, pkgs, config, lib, ... }:
let
  cfg = config.desktops.sway;
  sway-alttab = pkgs.callPackage ./sway-alttab/build { };
  # https://github.com/emersion/xdg-desktop-portal-wlr/wiki/"It-doesn't-work"-Troubleshooting-Checklist
  # note: this is pretty much the same as  /etc/sway/config.d/nixos.conf but also restarts
  # some user services to make sure they have the correct environment variables
  dbus-sway-environment = pkgs.writeShellApplication {
    name = "dbus-sway-environment";

    runtimeInputs = [ ];

    text = ''
        #!/usr/bin/env bash

      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };
in {
  options = {
    desktops.sway.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable sway Desktop";
    };
    desktops.sway.laptop = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Indicate if the system is a laptop";
    };
  };

  config = lib.mkIf cfg.enable {

    users = lib.mkMerge [
      (lib.mkIf cfg.laptop {
        users."${user-settings.user.username}".extraGroups = [ "video" ];
        # programs.light.enable = true;
        # Additional laptop-specific configurations can go here
      })
    ];

    cli = {
      foot.enable = true;
      yazi.enable = true;
    };

    services = {
      displayManager = {
        defaultSession = "sway";
        sddm = {
          enable = true;
          wayland.enable = true;
          autoNumlock = true;
          package = pkgs.kdePackages.sddm;

        };
      };
      # Configure keymap in X11
      xserver = {
        enable = true;
        xkb = {
          layout = "us";
          variant = "";
        };
      };
      gnome = {
        evolution-data-server.enable = true;
        gnome-online-accounts.enable = true;
        # Enable the gnome-keyring secrets vault.
        # Will be exposed through DBus to programs willing to store secrets
        gnome-keyring.enable = true;
      };
      gvfs.enable = true;
      accounts-daemon.enable = true;
      # greetd = {
      #   enable = true;
      #   settings = {
      #     default_session = {
      #       command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
      #       user = "greeter";
      #     };
      #   };
      # };
    };
    # Might not be needed
    security = {
      polkit.enable = true;
      pam = {
        services = {
          sddm.enableGnomeKeyring = true;
          # greetd = { enableGnomeKeyring = true; };
          swaylock = { };
          # keyring does not start otherwise - enable once I go to lightdm
          # lightdm.enableGnomeKeyring = true;
        };
      };
    };

    # kanshi systemd service
    systemd.user.services.kanshi = {
      description = "kanshi daemon";
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.kanshi}/bin/kanshi -c kanshi_config_file";
      };
    };

    fonts = {
      packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        font-awesome
        source-han-sans
        # source-han-sans-japanese
        # source-han-serif-japanese
        work-sans
        blueman
        pavucontrol
        grim
        swappy
        satty
        sway-alttab
      ];
      fontconfig.defaultFonts = {
        serif = [ "Work Sans" "Noto Serif" "Source Han Serif" ];
        sansSerif = [ "Work Sans" "Noto Sans" "Source Han Sans" ];
      };
    };

    environment = {

      systemPackages = with pkgs; [
        networkmanager
        accountsservice
        work-sans # font
        light
        pulseaudio
        wob
        dbus-sway-environment
      ];
    };

    # Enable variuos programs
    programs = {
      sway = {
        enable = true;
        wrapperFeatures.gtk = true;
        extraSessionCommands = ''
          export XDG_SESSION_DESKTOP=sway
          export MOZ_ENABLE_WAYLAND=1
          export MOZ_USE_XINPUT2=1
          export XDG_SESSION_TYPE=wayland
          export XDG_CURRENT_DESKTOP=sway
          export WLR_NO_HARDWARE_CURSORS=1
          export QT_QPA_PLATFORM=wayland
          # --- Testing below
          export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
          export QT_FONT_DPI=144
          export GNOME_KEYRING_CONTROL=/run/user/$UID/keyring
          export SSH_AUTH_SOCK=/run/user/$UID/keyring/ssh
          eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh);
          # WLR_RENDERER_ALLOW_SOFTWARE=1
        '';
      };
      seahorse.enable = true;

    };
    desktops.addons.waybar.enable = true;

    # xdg-desktop-portal exposes a series of D-Bus interfaces (APIs for file access, opening URIs, printing, etc)
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      # wlr.enable = true;
      # gtk portal needed to make gtk apps happy
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    ##### Home Manager Config options #####
    home-manager.users."${user-settings.user.username}" = {

      home.file.".config/sway/config".text = ''
        # Default config for sway
        #
        # Copy this to ~/.config/sway/config and edit it to your liking.
        #
        # Read `man 5 sway` for a complete reference.

        ### Variables
        #
        # Logo key. Use Mod1 for Alt.
        set $mod Mod4
        # Home row direction keys, like vim
        set $left h
        set $down j
        set $up k
        set $right l
        # Your preferred terminal emulator
        set $term foot
        # Your preferred application launcher
        # Note: pass the final command to swaymsg so that the resulting window can be opened
        # on the original workspace that the command was run on.
        # set $menu dmenu_path | wmenu | xargs swaymsg exec --
        # set $menu tofi-drun | xargs swaymsg exec --
        set $menu tofi-drun --drun-launch=true

        ### Kanshi Service
        # give sway a little time to startup before starting kanshi.
        exec sleep 5; systemctl --user start kanshi.service

        ### DBUS Sway Fixes
        #
        exec dbus-sway-environment

        ### Output configuration
        #
        # Default wallpaper (more resolutions are available in @datadir@/backgrounds/sway/)
        output * bg ~/Pictures/wallpapers/skullskates.png fill
        #
        # Example configuration:
        #
        #   output HDMI-A-1 resolution 1920x1080 position 1920,0
        #
        # You can get the names of your outputs by running: swaymsg -t get_outputs

        ### Idle configuration
        #
        # Example configuration:
        #
        # exec swayidle -w \
        #          timeout 300 'swaylock -f -c 000000' \
        #          timeout 600 'swaymsg "output * power off"' resume 'swaymsg "output * power on"' \
        #          before-sleep 'swaylock -f -c 000000'
        #
        # This will lock your screen after 300 seconds of inactivity, then turn off
        # your displays after another 300 seconds, and turn your screens back on when
        # resumed. It will also lock your screen before your computer goes to sleep.

        ### Input configuration
        #
        # Get device with: swaymsg -t get_inputs
        # Example configuration:
        #
          input "1267:12970:VEN_04F3:00_04F3:32AA_Touchpad" {
              dwt enabled
              tap enabled
              natural_scroll disabled
              middle_emulation enabled
          }
        #
        # You can get the names of your inputs by running: swaymsg -t get_inputs
        # Read `man 5 sway-input` for more information about this section.

        ### Key bindings
        #
        # Basics:
        #
            # Start a terminal
            bindsym $mod+Return exec $term

            # Kill focused window
            bindsym $mod+q kill

            # Start your launcher
            bindsym $mod+d exec $menu

            # Brightness
            bindsym XF86MonBrightnessDown exec light -U 10
            bindsym XF86MonBrightnessUp exec light -A 10

            # Volume
            bindsym XF86AudioRaiseVolume exec 'pactl set-sink-volume @DEFAULT_SINK@ +1%'
            bindsym XF86AudioLowerVolume exec 'pactl set-sink-volume @DEFAULT_SINK@ -1%'
            bindsym XF86AudioMute exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle'

            # Take Screenshots
            bindsym Ctrl+Alt+p exec grim -g "$(slurp)" - | swappy -f -

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
        #
        # Moving around:
        #
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
        #
        # Workspaces:
        #
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
        #
        # Layout stuff:
        #
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
            bindsym $mod+space focus mode_toggle

            # Move focus to the parent container
            bindsym $mod+a focus parent
        #
        # Scratchpad:
        #
            # Sway has a "scratchpad", which is a bag of holding for windows.
            # You can send windows there and get them back later.

            # Move the currently focused window to the scratchpad
            bindsym $mod+Shift+minus move scratchpad

            # Show the next scratchpad window or hide the focused scratchpad window.
            # If there are multiple scratchpad windows, this command cycles through them.
            bindsym $mod+minus scratchpad show
        #
        # Resizing containers:
        #
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

        #
        # Status Bar:
        #
        # Read `man 5 sway-bar` for more information about this section.
        # bar {
        #     position top

        #     # When the status_command prints a new line to stdout, swaybar updates.
        #     # The default just shows the current date and time.
        #     #status_command while date +'%Y-%m-%d %X'; do sleep 1; done

            # colors {
            #   statusline #cdd6f4
            #   background #1e1e2e
            #   inactive_workspace #1e1e2e00 #1e1e2e00 #a6adc8
            # }
        # }
        # replace swaybar with waybar
        # bar swaybar_command waybar
        exec waybar

        ### Visual
        #
        default_border pixel 2

        include @sysconfdir@/sway/config.d/*
      '';

      programs.tofi = {
        enable = true;
        settings = {
          anchor = "top";
          width = "100%";
          height = 30;
          horizontal = true;
          prompt-text = " run: ";
          outline-width = 0;
          border-width = 0;
          min-input-width = 120;
          result-spacing = 15;
          padding-top = 0;
          padding-bottom = 0;
          padding-left = 0;
          padding-right = 0;
        };
      };
      services = {
        mako.enable = true;
        gpg-agent.pinentryPackage = pkgs.pinentry-gnome3;
        # https://nixos.wiki/wiki/Bluetooth#Using_Bluetooth_headsets_with_PulseAudio
        mpris-proxy.enable = true;
      };

      # ##### THeme

      # gtk = {
      #   enable = true;
      #   cursorTheme = {
      #     name = "elementary";
      #     package = pkgs.pantheon.elementary-icon-theme;
      #     size = 32;
      #   };

      #   font = {
      #     name = "Work Sans 12";
      #     package = pkgs.work-sans;
      #   };

      #   gtk2 = {
      #     configLocation = "${user-settings.user.home}/.gtkrc-2.0";
      #     extraConfig = ''
      #       gtk-application-prefer-dark-theme = 1
      #       gtk-decoration-layout = ":minimize,maximize,close"
      #       gtk-theme-name = "io.elementary.stylesheet.bubblegum"
      #     '';
      #   };

      #   gtk3 = {
      #     extraConfig = {
      #       gtk-application-prefer-dark-theme = 1;
      #       gtk-decoration-layout = ":minimize,maximize,close";
      #     };
      #   };

      #   gtk4 = {
      #     extraConfig = {
      #       gtk-application-prefer-dark-theme = 1;
      #       gtk-decoration-layout = ":minimize,maximize,close";
      #     };
      #   };

      #   iconTheme = {
      #     name = "elementary";
      #     package = pkgs.pantheon.elementary-icon-theme;
      #   };

      #   theme = {
      #     name = "io.elementary.stylesheet.slate";
      #     package = pkgs.pantheon.elementary-gtk-theme;
      #   };
      # };

      home.pointerCursor = {
        size = 32;
        x11 = { enable = true; };
        gtk.enable = true;
      };
    };
  };
}
