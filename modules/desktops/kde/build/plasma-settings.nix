# nix run github:nix-community/plasma-manager > /home/dustin/dev/nix/nixos/modules/desktops/kde/build/plasma-manager.nix
{
  programs.plasma = {
    enable = true;
    shortcuts = {
      # Disable the default Meta+E shortcut for Dolphin
      "services/org.kde.dolphin.desktop"."_launch" = [ ];
      # Add a new Meta+E shortcut for VsCode
      "services/code.desktop"."_launch" = "Meta+E";
    };
    configFile = {
      # Turn off the NumLock key by default
      "kcminputrc"."Keyboard"."NumLock" = 1;
    };
  };
}
