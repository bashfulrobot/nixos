{ lib, config, inputs, pkgs, ... }: {

  # imports = [ ./hyprland ./sddm ];

  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks # Gnome Tweaks
    # Gnome Extensions
    gnomeExtensions.user-themes # User Themes
    gnomeExtensions.bluetooth-quick-connect # Bluetooth Quick Connect
    gnomeExtensions.just-perfection # Just Perfection
    gnomeExtensions.blur-my-shell # Blur my Shell
    gnomeExtensions.unite # Unite
    gnomeExtensions.quick-settings-audio-panel # Quick Settings Audio Panel
    # gnomeExtensions.forge
    gnomeExtensions.pop-shell # Pop Shell
    gnomeExtensions.appindicator # AppIndicator support
    gnomeExtensions.mullvad-indicator # Mullvad VPN
    gnome.nautilus # file manager
    gnome.adwaita-icon-theme # icon theme
    gnome.gnome-settings-daemon # settings daemon
    gnome2.GConf # configuration database system for old apps

  ];

  #   Dynamic triple buffering
  # Big merge request against Mutter improves the performance of the window manager by a lot (and is already used by Ubuntu). Not merged into nixpkgs due to philosophy of nixpkgs, but users are free to add this overlay to get it too.

  # Currently it's adapted for Gnome 45.
  nixpkgs.overlays = [
    (final: prev: {
      gnome = prev.gnome.overrideScope' (gnomeFinal: gnomePrev: {
        mutter = gnomePrev.mutter.overrideAttrs (old: {
          src = pkgs.fetchgit {
            url = "https://gitlab.gnome.org/vanvugt/mutter.git";
            # GNOME 45: triple-buffering-v4-45
            rev = "0b896518b2028d9c4d6ea44806d093fd33793689";
            sha256 = "sha256-mzNy5GPlB2qkI2KEAErJQzO//uo8yO0kPQUwvGDwR4w=";
          };
        });
      });
    })
  ];

  # You might need to disable aliases to make Dynamic triple buffering work:
  # nixpkgs.config.allowAliases = false;

}
