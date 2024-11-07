{ user-settings, config, lib, pkgs, ... }:
let
  cfg = config.sys.catppuccin-theme;

  # Type: one of “latte”, “frappe”, “macchiato”, “mocha”
  flavor = "mocha";

  # Type: one of “blue”, “flamingo”, “green”, “lavender”, “maroon”, “mauve”, “peach”, “pink”, “red”, “rosewater”, “sapphire”, “sky”, “teal”, “yellow”
  accent = "sky";

in {

  options = {
    sys.catppuccin-theme.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable catppuccin theme.";
    };
  };

  config = lib.mkIf cfg.enable {

    catppuccin = {
      enable = true;

      # set above in variables
      flavor = flavor;

      # set above in variables
      accent = accent;
    };

    home-manager.users."${user-settings.user.username}" = {

      catppuccin = {
        enable = true;

        # set above in variables
        flavor = flavor;

        # set above in variables
        accent = accent;
      };

    };
  };
}
