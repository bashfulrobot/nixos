<https://github.com/rtlewis1/GTK/archive/refs/heads/Numix-BLACK-Colors-Desktop.zip>

{ pkgs, ... }:
{
  gtk = {
    enable = true;
    theme = {
      name = "Materia-dark";
      package = pkgs.materia-theme;
    };
  };
}
