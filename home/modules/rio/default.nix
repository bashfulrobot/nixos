{ }: {
  programs.rio = {
    enable = true;
    settings = {
      cursor = "▇";
      blinking-cursor = true;
      theme = "pop";
      padding-x = 10;
      window = {
        foreground-opacity = 1.0;
        background-opacity = 0.96;
        blur = true;
        decorations = "Disabled";
      };
      fonts = {
        family = "MesloLGS NF";
        size = 28;
      };
      # shell = {
      #   program = "${pkgs.zellij}/bin/zellij";
      #   args = ["-s" "local-dev" "attach" "-c" "local-dev"];
      # };
    };
  };

  # More themes here: https://github.com/mbadolato/iTerm2-Color-Schemes/tree/master/rio
  home.file."pop.toml" = {
    source = ./themes/pop.toml;
    target = ".config/rio/themes/pop.toml";
  };
}
