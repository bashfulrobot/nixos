{ lib, config, inputs, pkgs, ... }: {

  # imports = [ ./hyprland ./sddm ];

  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb = {
      layout = "us";
      variant = "";
    };
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
    libadwaita # Adwaita libs
    gnome.gnome-tweaks # Gnome Tweaks
    pinentry-gnome3 # Gnome3 pinentry
    # Gnome Extensions
    gnomeExtensions.user-themes # User Themes
    gnomeExtensions.bluetooth-quick-connect # Bluetooth Quick Connect
    gnomeExtensions.just-perfection # Just Perfection
    # gnomeExtensions.fly-pie # Fly Pie mouse menu
    # gnomeExtensions.paperwm # tilig window manager
    gnomeExtensions.blur-my-shell # Blur my Shell
    gnomeExtensions.syncthing-icon # Syncthing Icon
    gnomeExtensions.quick-settings-audio-panel # Quick Settings Audio Panel
    gnomeExtensions.pop-shell # Pop Shell
    gnomeExtensions.appindicator # AppIndicator support
    gnomeExtensions.do-not-disturb-while-screen-sharing-or-recording # Automatically switches on the "Do Not Disturb" mode while screen sharing or screen recording. As soon as screen sharing/recording is over, "Do Not Disturb" mode will be switched back off.
    # gnomeExtensions.easyScreenCast # Simplifies the use of the video recording function integrated in gnome shell
    gnomeExtensions.fullscreen-notifications # Enables all notifications in fullscreen mode
    gnomeExtensions.undecorate # Add undecorate item in window menu. Use ALT+Space to show window menu
    gnomeExtensions.solaar-extension # Allow Solaar to support certain features on non X11 systems
    gnomeExtensions.just-perfection # Tweak Tool to Customize GNOME Shell, Change the Behavior and Disable UI Elements
    gnomeExtensions.looking-glass-button # Toggle the Looking Glass visibility by clicking on a panel icon.

    ## Extentions to try, or diusabled due to gnome shell version
    #gnomeExtensions.next-up # Show your next calendar event in the status bar
    #gnomeExtensions.hide-top-bar # Hide the top bar except in overview
    # gnomeExtensions.gtk4-desktop-icons-ng-ding # Libadwaita/Gtk4 port of Desktop Icons NG with GSconnect Integration, Drag and Drop on to Dock or Dash.
    # gnomeExtensions.gtk-title-bar # Remove title bars for non-GTK apps with minimal interference with the default workflow
    # gnomeExtensions.toggle-alacritty # Toggles Alacritty window via hotkey: Alt+z
    # Screenshot Directory
    # Hide Top Bar
    # Grand Theft Focus
    # gnomeExtensions.unite # Unite
    # gnomeExtensions.forge
    # gnomeExtensions.syncthing-indicator # Shell indicator for starting, monitoring and controlling the Syncthing daemon using SystemD
    # gnomeExtensions.syncthing-icon # Display Syncthing Icon in Top Bar
    # gnomeExtensions.gsconnect # GSConnect

    # Gnome apps/services
    gnome.nautilus # file manager
    gnome.adwaita-icon-theme # icon theme
    gnome.gnome-settings-daemon # settings daemon
    gnome2.GConf # configuration database system for old apps

  ];

  environment.excludePackages = with pkgs;
    [
      epiphany # web browser
    ];
  environment.gnome.excludePackages = with pkgs; [
    gnome.cheese # photo booth
    gedit # text editor
    gnome.yelp # help viewer
    gnome.file-roller # archive manager
    gnome.geary # email client

    # these should be self explanatory
    gnome.gnome-maps
    gnome.gnome-music
    gnome-photos
    gnome.gnome-system-monitor
    gnome.gnome-weather

    # disable gnome extensions
    gnomeExtensions.applications-menu
    gnomeExtensions.auto-move-windows
    gnomeExtensions.gtk-title-bar
    gnomeExtensions.gtk4-desktop-icons-ng-ding
    gnomeExtensions.hide-top-bar
    gnomeExtensions.launch-new-instance
    gnomeExtensions.light-style
    gnomeExtensions.native-window-placement
    gnomeExtensions.next-up
    gnomeExtensions.places-status-indicator
    gnomeExtensions.removable-drive-menu
    gnomeExtensions.screenshot-window-sizer
    gnomeExtensions.syncthing-indicator
    gnomeExtensions.window-list
    gnomeExtensions.windownavigator
    gnomeExtensions.workspace-indicator
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
