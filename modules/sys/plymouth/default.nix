{ config, pkgs, lib, ... }:
let cfg = config.sys.plymouth;
plymouthIcon = pkgs.callPackage ./build/icon.nix {};
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
      plymouthIcon
    ];
    boot.plymouth = {
      enable = true;
      font = "${pkgs.work-sans}/share/fonts/opentype/WorkSans-Regular.ttf";
      logo = "${plymouthIcon}/share/icons/hicolor/48x48/apps/plymouth.png";
      extraConfig = ''
        ShowDelay=0
        DeviceScale=2
      '';
    };

  };
}
