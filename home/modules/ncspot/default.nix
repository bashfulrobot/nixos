{ pkgs, ... }: {
  programs = {
    ncspot = {
      enable = true;
      settings = {
        notify = true;
        use_nerdfont = true;
        theme = {
          background = "#2d2d2d";
          primary = "#eeeeec";
          secondary = "#babdb6";
          title = "#729fcf";
          playing = "#ffffff";
          playing_selected = "#ffffff";
          playing_bg = "#729fcf";
          highlight = "#b88800";
          highlight_bg = "#2e3436";
          error = "#fce94f";
          error_bg = "#a40000";
          statusbar = "#ffffff";
          statusbar_progress = "#729fcf";
          statusbar_bg = "#555753";
          cmdline = "#eeeeec";
          cmdline_bg = "#2e3436";

        };
      };
    };
  };
}
