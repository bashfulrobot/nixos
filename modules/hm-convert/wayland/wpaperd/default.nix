{ pkgs, lib, config, ... }: {
  programs.wpaperd = {
    enable = true;
    settings = {
      default = {
        path = "${config.home.homeDirectory}/Pictures/Wallpapers";
        duration = "30m";
        apply-shadow = true;
        sorting = "random";
      };
      #   eDP-1 = {
      #     path = "/home/foo/Pictures/Wallpaper";
      #     apply-shadow = true;
      #   };
      #   DP-2 = {
      #     path = "/home/foo/Pictures/Anime";
      #     sorting = "descending";
      #   };
    };
  };
}
