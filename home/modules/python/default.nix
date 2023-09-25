{ pkgs, ... }:

with pkgs;
let
  default-python = python3.withPackages (python-packages:
    with python-packages; [
      pip
      beautifulsoup4
      # black
      # flake8
      # setuptools
      # wheel
      # twine
      # flake8
      # virtualenv
    ]);

in {
  home.packages = with pkgs;
    [

      # Called for above
      default-python

    ];

}
