# https://github.com/budimanjojo/dotfiles
{ user-settings, pkgs, config, lib, inputs, ... }:
let

  cfg = config.desktops.hyprland.config.keymaps;

in {

  options = {
    desktops.hyprland.config.keymaps.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Hyprland Keymaps";
    };
  };
  config = lib.mkIf cfg.enable {

    ##### Home Manager Config options #####
    home-manager.users."${user-settings.user.username}" = {

      wayland.windowManager = {
        hyprland = {
          settings = {

            # Keybindings
            bind = [

              # Close window
              "$mod, Q, killactive"

              # Lock screen
              "$mod, L, exec, hyprlock"

              # Reload the configuration file
              "$mod SHIFT, c, execr, hyprctl reload"

              # Rofi as dmenu replacement
              "$mod, Space, exec, rofi -show drun"
              # fake alt tab
              # "ALT, TAB, cyclenext"
              # "ALT, TAB, bringactivetotop"
              # "ALT, TAB, exec, hyprswitch --ignore-workspaces"
              # bind = $modifier $reverse, $key, exec, hyprswitch -r

              # rofi -show window -show-icons -format '{w}' -theme-str 'window {width: 20%;}'

              # Toggle fullscreen mode
              "$mod, f, fullscreen, 0"

              # Launch applications
              "$mod, B, exec, $browser"
              "$mod, E, exec, $gui-editor"
              "$mod, Return, exec, $terminal"
              "$mod SHIFT, F, exec, $filemanager"

              # Screenshot
              "$mod $alt, p, exec, $screenshotarea"

              # clipman pick
              "$mod, C, exec, clipman pick -t rofi -T='-p Clipboard'"

              "$mod ALT, E, exec, bemoji -c -n"

              # Modes
              "$mod SHIFT, r, submap, $resize"
              # ", print, submap, $screenshot"
              # "$mod $alt, p, submap, $screenshot"

              # Focus
              # Change focus around
              "$mod, $left, movefocus, l"
              "$mod, $down, movefocus, d"
              "$mod, $up, movefocus, u"
              "$mod, $right, movefocus, r"
              # Or use arrow keys
              "$mod, left, movefocus, l"
              "$mod, down, movefocus, d"
              "$mod, up, movefocus, u"
              "$mod, right, movefocus, r"

              # Move the focused window with the same, but add Shift
              "$mod SHIFT, $left, movewindow, l"
              "$mod SHIFT, $down, movewindow, d"
              "$mod SHIFT, $up, movewindow, u"
              "$mod SHIFT, $right, movewindow, r"
              # Or use arrow keys
              "$mod SHIFT, left, movewindow, l"
              "$mod SHIFT, down, movewindow, d"
              "$mod SHIFT, up, movewindow, u"
              "$mod SHIFT, right, movewindow, r"
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
          };

          # Submaps are impossible to be defined in settings
          extraConfig = ''
            # Resize window
            submap = $resize
            binde = , h, resizeactive, -10 0
            binde = , j, resizeactive, 0 10
            binde = , k, resizeactive, 0 -10
            binde = , l, resizeactive, 10 0
            # Or use arrow keys
            binde = , left, resizeactive, -10 0
            binde = , down, resizeactive, 0 10
            binde = , up, resizeactive, 0 -10
            binde = , right, resizeactive, 10 0
            # Return to normal mode
            bind = , escape, submap, reset
            submap = reset

            # Take a screenshot with grim, copy to clipboard, put it in Desktop folder
            submap = $screenshot
            bind = , return, execr, $grim_capture && pw-cat -p ~/.config/hypr/sounds/camera-shutter.oga && notify-send "Screenshot copied to clipboard and saved in your Desktop folder"
            bind = , return, submap, reset
            bind = , s, exec, $grim_region && pw-cat -p ~/.config/hypr/sounds/camera-shutter.oga && notify-send "Screenshot copied to clipboard and saved in your Desktop folder"
            bind = , s, submap, reset
            # Return to normal mode
            bind = , escape, submap, reset
            submap = reset
          '';

        };

      };
    };
  };
}
