{ user-settings, config, pkgs, lib, ... }:
let cfg = config.cli.wezterm;

in {

  options = {
    cli.wezterm.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the Wez terminal.";
    };
  };

  config = lib.mkIf cfg.enable {

    environment.variables.TERM = "wezterm";

    ### HOME MANAGER SETTINGS
    home-manager.users."${user-settings.user.username}" = {

      # TODO: remove this code
      # home.packages = with pkgs; [ mimeo ];

      programs.wezterm = {
        enable = true;
        enableZshIntegration = true;
        enableBashIntegration = true;
        extraConfig = ''
          local config = {}
          if wezterm.config_builder then
            config = wezterm.config_builder()
          end

          config.font_size = 14.0
          config.hide_tab_bar_if_only_one_tab = true
          config.window_close_confirmation = "NeverPrompt"
          config.default_prog = { "zsh" }

          return config
        '';

      };
    };
  };
}
