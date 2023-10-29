{ pkgs, ... }:
let gruvboxPlus = import ./gruvbox-plus.nix { inherit pkgs; };
in {
  # GTK
  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3";
    };
    iconTheme = {
      package = gruvboxPlus;
      name = "GruvboxPlus";
    };
  };

  # QT
  qt.enable = true;

}
