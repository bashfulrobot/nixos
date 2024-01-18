{ pkgs, ... }:

{
  # https://dandavison.github.io/delta
  # programs.git.delta = {
  #   enable = true;

  #   options = {
  #     line-numbers = true;
  #     # Note: compatible with Bat themes
  #     # syntax-theme = theme;
  #     hunk-header-style = "omit";
  #   };
  # };

  programs.lazygit = {
    enable = true;
    settings = {
      # git.paging.pager = "${pkgs.delta}/bin/delta --dark --paging=never";

      git = {
        parseEmoji = true;
        # paging.pager = "${pkgs.delta}/bin/delta --dark";
      };

      gui.theme = {
        lightTheme = false;
        nerdFontVersion = "3";

      };
    };
  };
}
