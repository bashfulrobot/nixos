{ pkgs }:

pkgs.writeShellApplication {
  name = "waybar-clock-hover";

  runtimeInputs = [ ];

  text = ''
    #!/run/current-system/sw/bin/env bash
    case "$1" in
      tooltip)
        # If called with "--tooltip", output the date
        date '+%Y-%m-%d'
        ;;
      *)
        # Default case: output the time
        date '+%H:%M'
        ;;
    esac
  '';
}
