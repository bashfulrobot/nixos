{ user-settings, pkgs, config, lib, ... }:
let
  cfg = config.sys.scripts.screenshots;
  screenshotOCR = ''
    #!/run/current-system/sw/bin/env bash

    # Directory where screenshots are stored
    dir="$HOME/Pictures/Screenshots"

    # TMP Dir
    TMPDIR=/tmp/screenshot-ocr
    mkdir -p $TMPDIR

    # Get the most recent screenshot
    recent_screenshot=$(/run/current-system/sw/bin/ls -t "$dir"/Screenshot\ from\ *.png | head -n1)

    # Check if a file was found
    if [[ -z "$recent_screenshot" ]]; then
        echo "No screenshot files found in $dir"
        exit 1
    fi

    # Process the screenshot with Tesseract and save the result to a text file in the temporary directory
    tesseract "$recent_screenshot" $TMPDIR/output

    # Copy the result to the clipboard
    # ignore all non-ASCII characters
    /run/current-system/sw/bin/cat $TMPDIR/output.txt |
        /run/current-system/sw/bin/tr -cd '\11\12\15\40-\176' | /run/current-system/sw/bin/grep . | /run/current-system/sw/bin/perl -pe 'chomp if eof' |
        /run/current-system/sw/bin/xclip -selection clipboard

    # Optionally, remove the temporary directory when done
    rm -r $TMPDIR
  '';

  screenshotAnnotateScript = ''
    #!/run/current-system/sw/bin/env bash

    # Directory where screenshots are stored
    dir="$HOME/Pictures/Screenshots"

    # Get the most recent screenshot
    # recent_screenshot=$(/run/current-system/sw/bin/ls -t "$dir"/Screenshot\ from\ *.png | head -n1)
    recent_screenshot=$(/run/current-system/sw/bin/ls -t "$dir"/*.png | head -n1)

    # Check if a file was found
    if [[ -z "$recent_screenshot" ]]; then
        echo "No screenshot files found in $dir"
        exit 1
    fi

    # Load the screenshot into the satty tool
    # satty --filename "$recent_screenshot" --init-tool arrow --fullscreen
    satty --filename "$recent_screenshot" --init-tool arrow --output-filename "$dir/annotated-$(date +%Y-%m-%d-%H-%M-%S).png"

    # Delete files older than 1 week
    find "$dir" -type f -mtime +7 -exec rm {} \;

    exit 0
  '';

in {
  options = {
    sys.scripts.screenshots.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the screenshot scripts.";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users."${user-settings.user.username}" = {
      home.packages = with pkgs; [
        (writeScriptBin "screenshot-annotate.sh" screenshotAnnotateScript)
        (writeScriptBin "screenshot-ocr.sh" screenshotOCR)
      ];
    };
  };
}
