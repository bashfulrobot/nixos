{ config, pkgs, lib, inputs, ... }:

{
  imports = [ # Include the results of the hardware scan.

    ./hardware # hardware specific configuration
    ../../modules/autoimport.nix # autoimport modules
    ../../archetype/autoimport.nix # autoimport archetype modules

  ];

  archetype = {
    laptop.enable = true;
    workstation.enable = true;
  };

  # User name specified in the settings
  users.default.enable = true;

  # snowfallorg.avalanche.desktop.enable = true;
  # desktops.avalanche.enable = true;
  desktops = {
    hyprland = {
      enable = true;
    };
    #  gnome.enable = true;
    # addons.wayland.enable = true;
  };

  # Testing
  # services.xserver.enable = true;
  # services.xserver.desktopManager.budgie.enable = true;
  # services.xserver.displayManager.lightdm.enable = true;
  # desktops.pantheon.enable = true;

  apps = {
    syncthing = {
      enable = true;
      host.evo = true;
    };

    chrome-based-browser = {
      enable = true;
      # Currently supported browsers are "brave", "vivaldi" or "chromium".
      browser = "brave";
    };

    desktopFile = {
      enable = true;
      reboot-firmware = true;
      seabird = true;
      beeper = true;
      monokle = false;
      cursor = false;
      spacedrive = false;
      reboot = true;
    };
  };

  networking.hostName = "evo"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
