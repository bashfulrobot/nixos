{ user-settings, pkgs, config, lib, ... }:
let
  cfg = config.apps.vscode;

in {
  options = {
    apps.vscode.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the vscode editor.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      unstable.vscode
    ];
    home-manager.users."${user-settings.user.username}" = {

      # force vscode to use wayland - https://skerit.com/en/make-electron-applications-use-the-wayland-renderer
      home.file.".config/code-flags.conf".text = ''
        --enable-features=UseOzonePlatform
        --ozone-platform=wayland
        --enable-features=WaylandWindowDecorations
      '';
    };
  };
}
