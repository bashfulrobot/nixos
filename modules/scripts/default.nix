{ pkgs, ... }:
let
  screenshotAnnotateScript = ''
    #!/usr/bin/env bash

    # Directory where screenshots are stored
    dir="$HOME/Pictures/Screenshots"

    # Get the most recent screenshot
    recent_screenshot=$(/run/current-system/sw/bin/ls -t "$dir"/Screenshot\ from\ *.png | head -n1)

    # Check if a file was found
    if [[ -z "$recent_screenshot" ]]; then
        echo "No screenshot files found in $dir"
        exit 1
    fi

    # Load the screenshot into the satty tool
    # satty --filename "$recent_screenshot" --init-tool arrow --fullscreen
    satty --filename "$recent_screenshot" --init-tool arrow --fullscreen --output-filename "$dir/annotated-$(date +%Y-%m-%d-%H-%M-%S).png"

    # Delete files older than 1 week
    find "$dir" -type f -mtime +7 -exec rm {} \;

    exit 0
  '';
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {
  home-manager.users."${username}" = {
    home.packages = with pkgs;
      [ (writeScriptBin "screenshot-annotate.sh" screenshotAnnotateScript) ];
  };
}
