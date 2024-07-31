{ user-settings, pkgs, lib, config, ... }:

let
  cfg = config.sys.scripts.gmail-url;
  gmailURL = pkgs.writeShellApplication {
    name = "gmail-url";

    runtimeInputs = [ pkgs.xclip pkgs.gnugrep ];

    text = ''
      #!/run/current-system/sw/bin/env bash

      # Step 1: Get the current URL from the clipboard
      current_url=$(xclip -o -selection clipboard)

      # Step 2: Extract the base URL and the message ID
      # The base URL pattern matches anything up to and including "/u/[number]/"
      # The message ID pattern matches the last alphanumeric sequence in the URL
      base_url=$(echo "$current_url" | grep -oE 'https://mail.google.com/mail/u/[0-9]+/')
      message_id=$(echo "$current_url" | grep -oE '[A-Za-z0-9]+$')

      # Step 3: Construct the new URL
      new_url="$base_url#all/$message_id"

      # Step 4: Set the new URL back to the clipboard
      echo "$new_url" | xclip -selection clipboard

      # Optional: Print the new URL to the terminal for verification
      # echo "New URL copied to clipboard: $new_url"

      exit 0
    '';
  };
in {
  options = {
    sys.scripts.gmail-url.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the gmail-url script.";
    };
  };
  config = lib.mkIf cfg.enable {
    #   environment.systemPackages = [ gmailURL ];
    home-manager.users."${user-settings.user.username}" = {
      home.packages = with pkgs;
        [
          gmailURL
        ];
    };
  };

}
