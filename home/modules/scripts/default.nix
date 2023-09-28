{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs;
    [
      (writeScriptBin "clipboard-ocr" ''
        #!/usr/bin/env bash

        grim  -g "$(slurp)" -t png /tmp/ocr-tmp.png')
        ${tesseract}/bin/tesseract /tmp/ocr-tmp.png /tmp/ocr-out

        ${coreutils}/bin/cat /tmp/ocr-out.txt | ${xclip}/bin/xclip -sel clip

        ${coreutils}/bin/rm /tmp/ocr-tmp.png
        ${coreutils}/bin/rm /tmp/ocr-out.txt

        exit 0
      '')
    ];
}
