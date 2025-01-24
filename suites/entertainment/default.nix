{ config, pkgs, lib, ... }:
let cfg = config.suites.entertainment;
in {

  options = {
    suites.entertainment.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable entertainment Apps.";
    };
  };

  config = lib.mkIf cfg.enable {
    cli = {
      spotify-player.enable = true;
      comics-downloader.enable = true;
    };

    environment.systemPackages = with pkgs; [
      transmission_4
      deluge-gtk
      vlc # media player
      foliate # ebook reader
      mplayer # Video player
      # spotdl # Spotify downloader
      mpv # Video Player - I use for remote youtube
    ];
  };
}
