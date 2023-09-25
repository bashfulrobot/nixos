{ pkgs, ... }: {

  home.file.".npmrc".text = ''
    prefix = ~/.npm-packages

  '';
}
