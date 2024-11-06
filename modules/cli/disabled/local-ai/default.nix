{
  user-settings,
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.cli.local-ai;
in {
  options = {
    cli.local-ai.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable local AI tools.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # ollama-rocm # run large language models locally, using ROCm for AMD GPU acceleration
    ];

    # config details - https://wiki.nixos.org/wiki/Ollama
    services.ollama = {
      enable = true;
      package = pkgs.ollama-rocm;
      acceleration = "rocm";
      # Get Version with:
      # nix-shell -p "rocmPackages.rocminfo" --run "rocminfo" | grep "gfx"
      # ie gfx1030 maps to 10.3.0, and gfx1031 would map to 10.3.1
      rocmOverrideGfx = "10.3.0";
    };

    home-manager.users."${user-settings.user.username}" = {
      # home manager config here
    };
  };
}
