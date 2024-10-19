# https://github.com/0xc000022070/zen-browser-flake
{ user-settings, pkgs, config, lib, inputs, ... }:
let
  cfg = config.apps.zen-browser;

in {
  options = {
    apps.zen-browser.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the zen browser.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      inputs.zen-browser.packages.x86_64-linux.specific
    ];
    home-manager.users."${user-settings.user.username}" = {

      # force vscode to use wayland - https://skerit.com/en/make-electron-applications-use-the-wayland-renderer
      # home.file.".config/code-flags.conf".text = ''
      #   --enable-features=UseOzonePlatform
      #   --ozone-platform=wayland
      #   --enable-features=WaylandWindowDecorations
      # '';
    };
  };
}
