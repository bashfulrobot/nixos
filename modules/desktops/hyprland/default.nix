{ user-settings, pkgs, config, lib, ... }:
let cfg = config.desktops.hyprland;

in {
  options = {
    desktops.hyprland.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Hyprlamd with Gnome.";
    };
  };

  config = lib.mkIf cfg.enable {

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    # Optional, hint electron apps to use wayland:
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    environment.systemPackages = with pkgs;
      [

      ];
    home-manager.users."${user-settings.user.username}" = {

      wayland.windowManager.hyprland = {
        enable = true;
        systemd.variables = [ "--all" ];

        settings = {
          "$mod" = "SUPER";
          bind =
            [ "$mod, B, exec, chromium" ", Print, exec, grimblast copy area" ]
            ++ (
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
      };

    };
  };
}
