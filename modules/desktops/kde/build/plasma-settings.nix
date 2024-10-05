# references:
#  - https://github.com/MatthiasBenaets/nix-config/blob/4052f95435b3251d05a4d18bdf7a69fd80c5c084/modules/desktops/kde.nix#L67
#  - https://github.com/nix-community/plasma-manager/blob/trunk/examples/homeManager/home.nix
#  - https://nix-community.github.io/plasma-manager/options.xhtml

{ lib, user-settings, ... }: {
  programs.plasma = {
    enable = true;
    #  Make fully declarative
    # overrideConfig = true;

    workspace = {
      clickItemTo = "select";
      # lookAndFeel = "org.kde.breezedark.desktop";
      # cursor.theme = "Bibata-Modern-Ice";
      iconTheme = "breeze-dark";
      wallpaper = "${user-settings.user.wallpaper}";
      splashScreen = {
        theme = "None";
        engine = "none";
      };
    };

    shortcuts = {
      # --- Applications ---

      # Disable the default Meta+E shortcut for Dolphin
      "services/org.kde.dolphin.desktop"."_launch" = [ ];
      # Add a new Meta+E shortcut for VsCode
      "services/code.desktop"."_launch" = "Meta+E";
      # Add a new Meta+B shortcut for Google Chrome
      "services/google-chrome.desktop"."_launch" = "Meta+B";

      # --- Windows ---

      # Reassign the Meta+Q shortcut to show the activity switcher to Meta+A
      "plasmashell"."manage activities" = "Meta+A";
      # Reassign the Meta+Q shortcut to close windows to Meta+Q,Alt+F4
      "kwin"."Window Close" = "Meta+Q";
      # Add a new Meta+F shortcut to make windows fullscreen
      "kwin"."Window Fullscreen" = "Meta+F";

      # --- Workspaces ---

      # Add a new Meta+1 shortcut to switch to Desktop 1
      "kwin"."Switch to Desktop 1" = "Meta+1";
      # Add a new Meta+2 shortcut to switch to Desktop 2
      "kwin"."Switch to Desktop 2" = "Meta+2";
      # Add a new Meta+3 shortcut to switch to Desktop 3
      "kwin"."Switch to Desktop 3" = "Meta+3";
      # Add a new Meta+4 shortcut to switch to Desktop 4
      "kwin"."Switch to Desktop 4" = "Meta+4";
      # Add a new Meta+Shift+1 shortcut to move app to Desktop 1
      "kwin"."Window to Desktop 1" = "Meta+!";
      # Add a new Meta+Shift+2 shortcut to move app to Desktop 2
      "kwin"."Window to Desktop 2" = "Meta+@";
      # Add a new Meta+Shift+3 shortcut to move app to Desktop 3
      "kwin"."Window to Desktop 3" = "Meta+#";
      # Add a new Meta+Shift+4 shortcut to move app to Desktop 4
      "kwin"."Window to Desktop 4" = "Meta+$";
    };
    # -- START PANELS
    panels = [{
      location = "left";
      alignment = "center";
      height = 34;
      hiding = "autohide";
      floating = true;
      screen = "all";
      extraSettings = ''
        panel.lengthMode = "fit";
      '';
      widgets = [
        # To get the names, it may be useful to look in the share/plasma/plasmoids folder of the nix-package the widget/plasmoid is from. Some packages which include some widgets/plasmoids are for example plasma-desktop and plasma-workspace.
        {
          name = "org.kde.plasma.kickoff";
          config = { General.icon = "nix-snowflake-white"; };
        }
        {
          name = "org.kde.plasma.icontasks";
          config = {
            General = {
              showOnlyCurrentActivity = "false";
              showOnlyCurrentDesktop = "false";
              launchers = lib.concatStrings (lib.intersperse "," [
                # "applications:systemsettings.desktop"
                # "applications:org.kde.dolphin.desktop"
                # "applications:google-chrome.desktop"
              ]);
            };
          };
        }
        "org.kde.plasma.clipboard"
        "org.kde.plasma.systemtray"
        "org.kde.plasma.digitalclock"
      ];
    }];

    # -- END PANELS

    kwin = {
      nightLight = {
        enable = true;
        mode = "times";
        time = {
          evening = "20:00";
          morning = "06:00";
        };
        transitionTime = 30;
      };
      effects = { shakeCursor.enable = true; };
      # titlebarButtons.right = [ "close" ];
      virtualDesktops.names = [ "Main" "Dev" "Comms" "Other" ];
    };

    input.keyboard.numlockOnStartup = "off";

    configFile = {
      # Set the default scale factor for Xwayland windows to 1.25
      "kwinrc"."Xwayland"."Scale" = 1.0;
      # Enable the "Allow Tearing" option in the Compositing settings
      "kwinrc"."Compositing"."AllowTearing" = true;
      # Set notification popups to appear in the top center of the screen
      "plasmanotifyrc"."Notifications"."PopupPosition" = "TopCenter";
      # Remove extra titlebar buttons from the window decoration
      "kwinrc"."org.kde.kdecoration2"."ButtonsOnRight" = "X";
      #  get all windows to show in alt tab
      "kwinrc"."TabBox"."ActivitiesMode" = 0;
      "kwinrc"."TabBox"."DesktopMode" = 0;
      #  show click effect when clicking
      "kwinrc"."Plugins"."mouseclickEnabled" = true;
      #  kwallet settings
      "kwalletrc"."Wallet"."Prompt on Open" = true;
    };
  };
}
