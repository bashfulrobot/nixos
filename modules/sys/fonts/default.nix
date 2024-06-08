{ user-settings, pkgs, config, lib, ... }:

let
  cfg = config.sys.fonts;
  sfpro-font = pkgs.callPackage ./build/sfpro { };
  sf-mono-liga-font = pkgs.callPackage ./build/sfpro/liga { };
  inter-font = pkgs.callPackage ./build/inter { }; # Helvetica Replacement
  aharoni-font = pkgs.callPackage ./build/aharoni { };
  monaspace-font = pkgs.callPackage ./build/monaspace { };


in {

  options = {
    sys.fonts.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable system fonts.";
    };
  };

  config = lib.mkIf cfg.enable {

    home-manager.users."${user-settings.user.username}" = {

      fonts.fontconfig.enable = true;

      home.packages = with pkgs; [
        monaspace-font
        aharoni-font
        inter-font
        sfpro-font
        sf-mono-liga-font
        roboto-slab
        fira
        fira-code
        fira-code-symbols
        font-awesome
        cantarell-fonts
        # comic-mono
        victor-mono
        # Meslo Nerd Font patched for Powerlevel10k
        meslo-lgs-nf
        # Helvetica for Camino
        helvetica-neue-lt-std
        # nerdfonts
        # (nerdfonts.override {
        #   fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" "SourceCodePro" ];
        # })
      ];
    };
  };
}
