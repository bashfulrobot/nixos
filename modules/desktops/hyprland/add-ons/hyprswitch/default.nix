{ user-settings, pkgs, config, lib, inputs, system, ... }:
with lib;
let cfg = config.desktops.hyprland.add-ons.hyprswitch;
in {
  options.desktops.hyprland.add-ons.hyprswitch.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable hyprswitch for hyprland";
  };

  config = mkIf cfg.enable {
    #     environment.systemPackages = with pkgs;
    #       [
    #         systemPackages = with pkgs; [
    #          inputs.hyprswitch.packages.x86_64-linux.default
    #       ];
    #       ];

    #     home-manager.users.${user-settings.user.username} = {
    #       wayland.windowManager.hyprland = {

    #         plugins = [ pkgs.hyprlandPlugins.hyprspace ];

    #         # https://github.com/KZDKM/Hyprspace
    #         settings = {
    #           #  variables
    #           "$mod" = "SUPER";
    #           "$alt" = "ALT";

    #           bind = [
    #             "ALT, tab, overview:toggle"
    #             "$mod, Tab, workspace,m-1"
    #             "$mod SHIFT, Tab, workspace,r+1"
    #             ];

    #         # Submaps are impossible to be defined in settings
    #           extraConfig = ''
    #             # switch window
    #             submap = $switch-window`
    #             binde = , h, resizeactive, -10 0
    #             binde = , j, resizeactive, 0 10
    #             binde = , k, resizeactive, 0 -10
    #             binde = , l, resizeactive, 10 0
    #             # Or use arrow keys
    #             binde = , left, resizeactive, -10 0
    #             binde = , down, resizeactive, 0 10
    #             binde = , up, resizeactive, 0 -10
    #             binde = , right, resizeactive, 10 0
    #             # Return to normal mode
    #             bind = , escape, submap, reset
    #             submap = reset

    #             # Take a screenshot with grim, copy to clipboard, put it in Desktop folder
    #             submap = $screenshot
    #             bind = , return, execr, $grim_capture && pw-cat -p ~/.config/hypr/sounds/camera-shutter.oga && notify-send "Screenshot copied to clipboard and saved in your Desktop folder"
    #             bind = , return, submap, reset
    #             bind = , s, exec, $grim_region && pw-cat -p ~/.config/hypr/sounds/camera-shutter.oga && notify-send "Screenshot copied to clipboard and saved in your Desktop folder"
    #             bind = , s, submap, reset
    #             # Return to normal mode
    #             bind = , escape, submap, reset
    #             submap = reset
    #           '';

    #         };

    #       };
    #     };
  };
}
