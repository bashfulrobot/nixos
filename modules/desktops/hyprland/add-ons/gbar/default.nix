{ user-settings, pkgs, config, lib, inputs, system, ... }:
with lib;
let cfg = config.desktops.hyprland.add-ons.gbar;
in {
  options.desktops.hyprland.add-ons.gbar.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable gbar for hyprland";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [
        inputs.gBar.defaultPackage.x86_64-linux
        pamixer
        ];

    home-manager.users.${user-settings.user.username} = {

      home.file = { ".config/gBar/config".source = ./build/cfg/config; };
      home.file = { ".config/gBar/style.scss".source = ./build/cfg/style.scss; };

    };
  };
}
