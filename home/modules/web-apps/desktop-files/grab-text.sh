#!/usr/bin/env bash

cd ~/Pictures/Screentshots
rm -f *.png
tesseract *.png output && cat -p output.txt | xclip -selection clipboard && rm *.png && rm output.txt
