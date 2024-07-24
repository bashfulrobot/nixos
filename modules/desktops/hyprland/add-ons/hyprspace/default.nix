{ user-settings, pkgs, config, lib, inputs, system, ... }:
with lib;
let cfg = config.desktops.hyprland.add-ons.hyprspace;
in {
  options.desktops.hyprland.add-ons.hyprspace.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable hyprspace for hyprland";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [
        #waybar-clock-hover
      ];

    home-manager.users.${user-settings.user.username} = {
      wayland.windowManager.hyprland = {

        plugins = [ pkgs.hyprlandPlugins.hyprspace ];

        # https://github.com/KZDKM/Hyprspace
        settings = {
          #  variables
          "$mod" = "SUPER";
          "$alt" = "ALT";

          "plugin:overview" = {

            gapsIn = 10;
            gapsOut = 10;

            autoDrag = true;
            autoScroll = true;
            # switchOnDrop = true;
            # exitOnClick = true;
            exitOnSwitch = true;
            showNewWorkspace = true;
            showEmptyWorkspace = false;
            workspace_swipe_fingers = 3;

          };

          bind = [
            "ALT, tab, overview:toggle"
            "$mod, Tab, workspace,m-1"
            "$mod SHIFT, Tab, workspace,r+1"
            ];

        };

      };
    };
  };
}
