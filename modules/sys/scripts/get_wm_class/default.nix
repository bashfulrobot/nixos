{ user-settings, pkgs, lib, config, ... }:

let
  cfg = config.sys.scripts.get_wm_class;
  get_wm_class = pkgs.writeShellApplication {
    name = "get_wm_class";

    runtimeInputs = [ pkgs.wl-clipboard pkgs.fzf ];

    text = ''
      #!/run/current-system/sw/bin/env bash

      # Check if hyprctl is installed
      if command -v hyprctl &> /dev/null
      then
          # Execute the original commands
          hyprctl clients | grep 'class:' | awk '{print $2}' | fzf | wl-copy --trim-newline
      else
          # Fallback to gdbus if hyprctl is not found
          gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell/Extensions/Windows --method org.gnome.Shell.Extensions.Windows.List | grep -Po '"wm_class_instance":"\K[^"]*' | fzf | wl-copy --trim-newline
      fi

      exit 0
    '';
  };
in {
  options = {
    sys.scripts.get_wm_class.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the get_wm_class script.";
    };
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ get_wm_class ];
    home-manager.users."${user-settings.user.username}" = {
      # home.packages = with pkgs; [ get_wm_class wl-clipboard fzf ];
    };
  };

}
