{ user-settings, lib, config, pkgs, inputs, ... }:
let cfg = config.desktops.budgie.keybindings;
in {

  options = {
    desktops.budgie.keybindings.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable budgie.keybindings.";
    };
  };

  config = lib.mkIf cfg.enable {

    # environment.systemPackages = with pkgs; [
    #  ];

    home-manager.users."${user-settings.user.username}" = {
      dconf.settings = with inputs.home-manager.lib.hm.gvariant; {

        #disable super key for default launcher in mutter
        "org/gnome/mutter" = {
        overlay-key = "";
        };

        #  Set Media Keys
        "org/gnome/settings-daemon/plugins/media-keys" = {
          play = [ "AudioPlay" ];
          volume-down = [ "AudioLowerVolume" ];
          volume-mute = [ "AudioMute" ];
          volume-up = [ "AudioRaiseVolume" ];
        };

        "org/gnome/shell/keybindings" = {
          show-screenshot-ui = [ ];
          switch-to-application-1 = [ ];
          switch-to-application-2 = [ ];
          switch-to-application-4 = [ ];
        };

        "org/gnome/desktop/wm/keybindings" = {
          close = [ "<Super>q" ];
          switch-applications = [ "<Alt>Tab" ];
          switch-applications-backward = [ "<Shift><Alt>Tab" ];
          # switch-windows = [ "<Alt>Tab" ];
          # switch-windows-backward = [ "<Shift><Alt>Tab" ];
          toggle-fullscreen = [ "<Super>f" ];
          maximize = [ "<Super>Up"];
          unmaximize = ["<Super>Down" ];
          switch-to-workspace-1 = [ "<Super>1" ];
          switch-to-workspace-2 = [ "<Super>2" ];
          switch-to-workspace-3 = [ "<Super>3" ];
          switch-to-workspace-4 = [ "<Super>4" ];
          switch-to-workspace-5 = [ "<Super>5" ];
          switch-to-workspace-6 = [ "<Super>6" ];
          switch-to-workspace-7 = [ "<Super>7" ];
          switch-to-workspace-8 = [ "<Super>8" ];
          switch-to-workspace-9 = [ "<Super>9" ];

          move-to-workspace-1 = [ "<Shift><Super>1" ];
          move-to-workspace-2 = [ "<Shift><Super>2" ];
          move-to-workspace-3 = [ "<Shift><Super>3" ];
          move-to-workspace-4 = [ "<Shift><Super>4" ];
          move-to-workspace-5 = [ "<Shift><Super>5" ];
          move-to-workspace-6 = [ "<Shift><Super>6" ];
          move-to-workspace-7 = [ "<Shift><Super>7" ];
          move-to-workspace-8 = [ "<Shift><Super>8" ];
          move-to-workspace-9 = [ "<Shift><Super>9" ];
          toggle-message-tray = [ "<Shift><Super>n" ];
          panel-run-dialog = [ ];
          switch-input-source = [ ];
          switch-input-source-backward = [ ];
        };

        #  Custom Keybindings
        "org/gnome/settings-daemon/plugins/media-keys" = {
          custom-keybindings = [
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom6/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom7/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom8/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom9/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom10/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom11/"
          ];
        };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" =
          {
            binding = "<Super>t";
            # binding = "<Super>space";
            # command = "kgx";
            command = "alacritty";
            name = "Terminal";
          };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" =
          {
            binding = "<Control><Alt>a";
            command =
              "/etc/profiles/per-user/dustin/bin/screenshot-annotate.sh";
            name = "Annotate Screenshot";
          };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" =
          {
            binding = "<Super>b";
            command = "chromium";
            name = "Browser";
          };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" =
          {
            binding = "<Super>e";
            command = "code";
            name = "Editor";
          };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4" =
          {
            binding = "<Control><Alt>o";
            command = "/etc/profiles/per-user/dustin/bin/screenshot-ocr.sh";
            name = "OCR Screenshot";
          };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5" =
          {
            binding = "<Control><Shift>x";
            command = "/run/current-system/sw/bin/1password --quick-access";
            name = "1password quick access";
          };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom6" =
          {
            binding = "<Alt>p";
            command = "/run/current-system/sw/bin/1password --toggle";
            name = "show 1password";
          };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom7" =
          {
            binding = "<Super>n";
            command = "/etc/profiles/per-user/dustin/bin/nautilus ~/dev";
            name = "open files in ~/dev";
          };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom8" =
          {
            binding = "<Control><Alt><Super>g";
            command = "gmail-url";
            name = "Transform gmail url to archive url on your clipboard";
          };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom9" =
          {
            binding = "<Control><Alt>space";
            # command = "toggle-cursor-size";
            command = "toggle-projecteur";
            name = "toggle large cursor in presentations";
          };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom10" =
          {
            binding = "<Control><Alt>p";
            command = "org.buddiesofbudgie.BudgieScreenshot -a";
            name = "Screentshot";
          };

        # wpctl status - look for proper ID
        #  wpctl set-default ID - by id it knows sink our source.
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom11" =
          {
            binding = "<Super><Shift>A";
            command = "set-audio-in-out";
            name = "Set Audio Devices";
          };

      };

    };

  };
}
