{ pkgs, ... }: {
  programs = {
    ncspot = {
      enable = true;
      settings = {
        notify = true;
        use_nerdfont = true;
        theme = {
          background = "#282828";
          primary = "#ebdbb2";
          secondary = "#d5c4a1";
          title = "#83a598";
          playing = "#fbf1c7";
          playing_selected = "#fbf1c7";
          playing_bg = "#83a598";
          highlight = "#fe8019"; # Replaced green with orange (#fe8019)
          highlight_bg = "#2e2e2e"; # Adjusted background for better contrast
          error = "#cc241d"; # Replaced green with red (#cc241d)
          error_bg = "#a40000";
          statusbar = "#fbf1c7";
          statusbar_progress = "#83a598";
          statusbar_bg = "#282828";
          cmdline = "#ebdbb2";
          cmdline_bg = "#2e2e2e";
        };
      };
    };
  };
}

