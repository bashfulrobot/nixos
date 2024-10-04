# nix run github:nix-community/plasma-manager > /home/dustin/dev/nix/nixos/modules/desktops/kde/build/plasma-manager.nix
{
  programs.plasma = {
    enable = true;
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
      "plasmashell"."manage activities" =
        "Meta+A,Meta+Q,Show Activity Switcher";
      # Reassign the Meta+Q shortcut to close windows to Meta+Q,Alt+F4
      "kwin"."Window Close" = "Meta+Q,Alt+F4,Close Window";
      # Add a new Meta+F shortcut to make windows fullscreen
      "kwin"."Window Fullscreen" = "Meta+F,,Make Window Fullscreen";

      # --- Workspaces ---

      # Add a new Meta+1 shortcut to switch to Desktop 1
      "kwin"."Switch to Desktop 1" =
        [ "Meta+1" "Ctrl+F1,Ctrl+F1,Switch to Desktop 1" ];
      # Add a new Meta+2 shortcut to switch to Desktop 2
      "kwin"."Switch to Desktop 2" =
        [ "Ctrl+F2" "Meta+2,Ctrl+F2,Switch to Desktop 2" ];
      # Add a new Meta+3 shortcut to switch to Desktop 3
      "kwin"."Switch to Desktop 3" =
        [ "Ctrl+F3" "Meta+3,Ctrl+F3,Switch to Desktop 3" ];
      # Add a new Meta+4 shortcut to switch to Desktop 4
      "kwin"."Switch to Desktop 4" =
        [ "Meta+4" "Ctrl+F4,Ctrl+F4,Switch to Desktop 4" ];
      # Add a new Meta+Shift+1 shortcut to move app to Desktop 1
      "kwin"."Window to Desktop 1" = "Meta+!,,Window to Desktop 1";
      # Add a new Meta+Shift+2 shortcut to move app to Desktop 2
      "kwin"."Window to Desktop 2" = "Meta+@,,Window to Desktop 2";
      # Add a new Meta+Shift+3 shortcut to move app to Desktop 3
      "kwin"."Window to Desktop 3" = "Meta+#,,Window to Desktop 3";
      # Add a new Meta+Shift+4 shortcut to move app to Desktop 4
      "kwin"."Window to Desktop 4" = "Meta+$,,Window to Desktop 4";
    };
    configFile = {
      # Turn off the NumLock key by default
      "kcminputrc"."Keyboard"."NumLock" = 1;
      # Set the default scale factor for Xwayland windows to 1.25
      "kwinrc"."Xwayland"."Scale" = 1.25;
      # Enable the "Allow Tearing" option in the Compositing settings
      "kwinrc"."Compositing"."AllowTearing" = true;
      # Show large cursor when shaking the mouse
      "kwinrc"."Plugins"."shakecursorEnabled" = true;
      # Set the magnification level for the large cursor
      "kwinrc"."Effect-shakecursor"."Magnification" = 7;
      # Enable the Night Color feature
      "kwinrc"."NightColor"."Active" = true;
      # Set the Night Color mode to "Times" with a fixed evening begin time of 8:00 PM
      "kwinrc"."NightColor"."EveningBeginFixed" = 2000;
      "kwinrc"."NightColor"."Mode" = "Times";
      # Remove extra titlebar buttons from the window decoration
      "kwinrc"."org.kde.kdecoration2"."ButtonsOnRight" = "X";
      # Set the default icon theme to Breeze Dark
      "kdeglobals"."Icons"."Theme" = "breeze-dark";
      # Remove the splash screen
      "ksplashrc"."KSplash"."Engine" = "none";
      "ksplashrc"."KSplash"."Theme" = "None";
      # Set notification popups to appear in the top center of the screen
      "plasmanotifyrc"."Notifications"."PopupPosition" = "TopCenter";
      #  get all windows to show in alt tab
      "kwinrc"."TabBox"."ActivitiesMode" = 0;
      "kwinrc"."TabBox"."DesktopMode" = 0;
      #  show click effect when clicking
      "kwinrc"."Plugins"."mouseclickEnabled" = true;
      # Rename Workspaced
      "kwinrc"."Desktops"."Id_2" = "ecbf5aaf-cefd-45c4-9a3f-0b953a4d1c0e";
      "kwinrc"."Desktops"."Id_3" = "f180f867-0014-4d04-a7ba-f3572b7cbce6";
      "kwinrc"."Desktops"."Id_4" = "c0a7aefa-cc25-4abc-8669-c0ee1bbbd20b";
      "kwinrc"."Desktops"."Id_1" = "7dbc52e2-f403-40fc-a3be-25199516c16b";
      "kwinrc"."Desktops"."Name_1" = "Main";
      "kwinrc"."Desktops"."Name_2" = "Dev";
      "kwinrc"."Desktops"."Name_3" = "Comms";
      "kwinrc"."Desktops"."Name_4" = "Other";
      "kwinrc"."Desktops"."Number" = 4;
      #  kwallet settings
      "kwalletrc"."Wallet"."Prompt on Open" = true;
    };
  };
}
