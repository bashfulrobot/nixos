{ pkgs }:

pkgs.writeShellApplication {
  name = "lockman";

  runtimeInputs = [ pkgs.swaylock pkgs.swayidle ];

  text = ''
    #!/usr/bin/env bash

    # Ensure swaylock and swayidle are available
    if ! command -v swaylock &>/dev/null || ! command -v swayidle &>/dev/null; then
      echo "Required commands not found" >&2
      exit 1
    fi

    # Times the screen off and puts it to background
    swayidle \
      timeout 10 'swaymsg "output * dpms off"' \
      resume 'swaymsg "output * dpms on"' &
    swayidle_pid=$!

    # Locks the screen immediately
    if ! swaylock --indicator-radius 100 --indicator-thickness 7 --font "Work Sans" --font-size 18 --indicator-caps-lock; then
      echo "Failed to lock the screen" >&2
      kill $swayidle_pid
      exit 1
    fi

    # Kills swayidle background task
    kill $swayidle_pid

    exit 0
  '';
}
