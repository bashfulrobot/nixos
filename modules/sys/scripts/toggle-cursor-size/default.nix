{ user-settings, pkgs, lib, config, ... }:

let
  cfg = config.sys.scripts.toggle-cursor-size;
  toggleCursorSize = pkgs.writeShellApplication {
    name = "toggle-cursor-size";

    # runtimeInputs = [ pkgs.restic pkgs.pass ];

    text = ''
      #!/run/current-system/sw/bin/env bash

      # Get the current cursor size
      current_size=$(dconf read /org/gnome/desktop/interface/cursor-size)

      # Toggle the cursor size
      if [ "$current_size" -eq 120 ]; then
        dconf write /org/gnome/desktop/interface/cursor-size 25
        dconf write /org/gnome/desktop/interface/cursor-theme "'Adwaita'"
      elif [ "$current_size" -eq 25 ]; then
        dconf write /org/gnome/desktop/interface/cursor-size 120
        dconf write /org/gnome/desktop/interface/cursor-theme "'Bibata-Modern-Amber'"
      else
        dconf write /org/gnome/desktop/interface/cursor-size 120
        dconf write /org/gnome/desktop/interface/cursor-theme "'Bibata-Modern-Amber'"
      fi

      exit 0
    '';
  };
in {
  options = {
    sys.scripts.toggle-cursor-size.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the toggle-cursor-size script.";
    };
  };
  config = lib.mkIf cfg.enable {
    #   environment.systemPackages = [ toggleCursorSize ];
    home-manager.users."${user-settings.user.username}" = {
      home.packages = with pkgs; [ toggleCursorSize bibata-cursors ];
    };
  };

}
