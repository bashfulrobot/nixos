{ config, pkgs, lib, ... }:
let cfg = config.sys.plymouth;
in {

  options = {
    sys.plymouth.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Plymouth.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      dconf
      dconf2nix
      dconf-editor

    ];
    # Enable dconf
    boot.plymouth = {
      enable = true;
      font = "${pkgs.work-sans}/share/fonts/opentype/WorkSans-Regular.ttf";
      logo = pkgs.fetchurl {
        url = "https://nixos.org/logo/nixos-hires.png";
        sha256 = "1ivzgd7iz0i06y36p8m5w48fd8pjqwxhdaavc0pxs7w1g7mcy5si";
      };
    };

  };
}
