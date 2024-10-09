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
          "$mod" = "SUPER";
          exec-once = [
            "waybar"
          ];
          bind = [
            "$mod, Space, exec, wofi --show"
            "$mod, B, exec, google-chrome-stable"
            "$mod, T, exec, alacritty"
            ", Print, exec, grimblast copy area"
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
      };

    };
  };
}
