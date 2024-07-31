{ user-settings, pkgs, lib, config, ... }:

let
  cfg = config.sys.scripts.copy_icons;
  copyIcons = pkgs.writeShellApplication {
    name = "copy_icons";

    runtimeInputs = [ ];

    text = ''
      #!/run/current-system/sw/bin/env bash

      # Copy all icons from Chromium Web Apps to the target directory

      # I create the web app in brave temporarily to get all the icons at multiple sizes
      # then I copy them to the target directory
      # then remove the brave web app and define it in nix

      if [ -z "$1" ]; then
          echo "Error: No target directory provided."
          echo "Usage: $0 target_directory"
          exit 1
      fi

      target_dir=$1
      target_path="$HOME/dev/nix/nixos/modules/apps/$target_dir/icons/"

      if [ ! -d "$target_path" ]; then
          mkdir -p "$target_path"
      fi

      # Copy all files from the Icons subdirectory to the target directory
      cp "$HOME/.config/chromium/Default/Web\ Applications/Manifest\ Resources/*/Icons/*" "$target_path"

      exit 0
    '';
  };
in {
  options = {
    sys.scripts.copy_icons.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the copy_icons.";
    };
  };
  config = lib.mkIf cfg.enable {
    #   environment.systemPackages = [ copyIcons ];
    home-manager.users."${user-settings.user.username}" = {
      home.packages = with pkgs; [ copyIcons ];
    };
  };

}
