{ pkgs, config, lib, ... }:
let
  cfg = config.apps.vscode;
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
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
      vscode
    ];
    home-manager.users."${username}" = {

      # force vscode to use wayland - https://skerit.com/en/make-electron-applications-use-the-wayland-renderer
      home.file.".config/code-flags.conf".text = ''
        --enable-features=UseOzonePlatform
        --ozone-platform=wayland
      '';
    };
  };
}
