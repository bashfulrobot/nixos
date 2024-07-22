{ config, pkgs, lib, inputs, secrets, ... }:

{
  imports = [ # Include the results of the hardware scan.

    ./hardware # hardware specific configuration
    ./video # video specific configuration
    ./kvm-routing # kvm routing specific configuration
    ../../modules/autoimport.nix # autoimport modules
    ../../archetype/autoimport.nix # autoimport archetype modules
  ];
  # User name specified in the settings
  users.default.enable = true;

  archetype = {
    tower.enable = true;
    workstation.enable = true;
  };

  desktops = {
    # sway = {
    sway-dev = {
      enable = true;
      laptop = false;
      themes.catppuccin.enable = true;
    };
    # hyprland = { enable = true; };
    #  gnome.enable = true;
    addons.wayland.enable = true;
  };

  # Testing
  # services.xserver.enable = true;
  # services.xserver.desktopManager.budgie.enable = true;
  # services.xserver.displayManager.lightdm.enable = true;

  apps = {
    syncthing = {
      enable = true;
      host.rembot = true;
    };

    chrome-based-browser = {
      enable = true;
      # Currently supported browsers are "brave", "vivaldi" or "chromium".
      browser = "brave";
      disableWayland = false;
    };

    desktopFile = {
      enable = true;
      reboot-firmware = true;
      reboot-windows = true;
      reboot = true;
      seabird = true;
      beeper = true;
      monokle = false;
      cursor = false;
      spacedrive = false;
      solaar = true;
      warp = false;

    };
  };

  networking.hostName = "rembot"; # Define your hostname.

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
