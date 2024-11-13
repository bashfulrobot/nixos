# TODO: Clean up fonts - what am I "actually" using?
{ user-settings, pkgs, config, lib, ... }:

let
  cfg = config.sys.fonts;
  sfpro-font = pkgs.callPackage ./build/sfpro { };
  sf-mono-liga-font = pkgs.callPackage ./build/sfpro/liga { };
  inter-font = pkgs.callPackage ./build/inter { }; # Helvetica Replacement
  aharoni-font = pkgs.callPackage ./build/aharoni { };
  # monaspace-font = pkgs.callPackage ./build/monaspace { };

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
      # fc-list | grep [font name] -> before the ":" is the font name
      home.packages = with pkgs; [
        # monaspace-font
        work-sans
        aharoni-font
        inter-font
        sfpro-font
        sf-mono-liga-font
        roboto-slab
        fira
        fira-code
        fira-code-symbols
        fira-code-nerdfont
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
        #   fonts =
        #     [ "FiraCode" "DroidSansMono" "JetBrainsMono" "SourceCodePro" ];
        # })
        # if you hover over the download links on the site, the name of the zip file is the font name.
        (nerdfonts.override {
          fonts =
            [ "DroidSansMono" "JetBrainsMono" "Ubuntu" "UbuntuMono" "UbuntuSans" ];
        })
      ];
    };
  };
}
