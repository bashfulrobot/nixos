# https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/
{ user-settings, pkgs, config, lib, ... }:
let cfg = config.desktops.hyprland.wofi;

in {
  options = {
    desktops.hyprland.wofi.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable wofi Launcher.";
    };
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = with pkgs;
      [

      ];

    home-manager.users."${user-settings.user.username}" = {
      programs.wofi = {
        enable = true;
        # style = ''
        #   * {
        #     font-family: FiraCode Nerd Font Mono;
        #   }
        #   window {
        #     background-color: #7c818c;
        #   }
        # '';
        settings = {
          show = "drun";
          allow_markup = true;
          image_size = 48;
          columns = 1;
          allow_images = true;
          insensitive = true;
          run-always_parse_args = true;
          run-cache_file = "/dev/null";
          run-exec_search = true;
          matching = "multi-contains";
          width = 450;
          # Testing below
          prompt = "Apps";
          layer = "top";
          orientation = "vertical";
          halign = "fill";
          line_wrap = "off";
          dynamic_lines = false;
          exec_search = false;
          hide_search = false;
          parse_search = false;
          hide_scroll = true;
          no_actions = true;
          sort_order = "default";
          gtk_dark = true;
          filter_rate = 100;
          key_expand = "Tab";
          key_exit = "Escape";
        };
      };
    };
  };
}
