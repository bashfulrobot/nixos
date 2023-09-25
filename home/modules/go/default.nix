{ pkgs, ... }:
{
  programs.go = {
    enable = true;
    goBin = "go/bin";
    goPath = "go";
  };
}
