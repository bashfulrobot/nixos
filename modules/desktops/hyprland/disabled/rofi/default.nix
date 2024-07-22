{ user-settings, pkgs, config, lib, inputs, ... }:
let

  cfg = config.desktops.hyprland.rofi;

in {
  options = {
    desktops.hyprland.rofi.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable rofi in Hyprland Desktop";
    };
  };
  config = lib.mkIf cfg.enable {

    ##### Home Manager Config options #####
    home-manager.users."${user-settings.user.username}" = {

      home.file.".config/rofi/gruvbox-dark-soft.rasi".text = ''
        /* ==========================================================================
           Rofi color theme

           Based on the Gruvbox color scheme for Vim by morhetz
           https://github.com/morhetz/gruvbox

           File: gruvbox-dark-soft.rasi
           Desc: Gruvbox dark (soft contrast) color theme for Rofi
           Author: bardisty <b@bah.im>
           Source: https://github.com/bardisty/gruvbox-rofi
           Modified: Mon Feb 12 2018 06:04:37 PST -0800
           ========================================================================== */

        * {
            /* Theme settings */
            highlight: bold italic;
            scrollbar: true;

            /* Gruvbox dark colors */
            gruvbox-dark-bg0-soft:     #32302f;
            gruvbox-dark-bg1:          #3c3836;
            gruvbox-dark-bg3:          #665c54;
            gruvbox-dark-fg0:          #fbf1c7;
            gruvbox-dark-fg1:          #ebdbb2;
            gruvbox-dark-red-dark:     #cc241d;
            gruvbox-dark-red-light:    #fb4934;
            gruvbox-dark-yellow-dark:  #d79921;
            gruvbox-dark-yellow-light: #fabd2f;
            gruvbox-dark-gray:         #a89984;

            /* Theme colors */
            background:                  @gruvbox-dark-bg0-soft;
            background-color:            @background;
            foreground:                  @gruvbox-dark-fg1;
            border-color:                @gruvbox-dark-gray;
            separatorcolor:              @border-color;
            scrollbar-handle:            @border-color;

            normal-background:           @background;
            normal-foreground:           @foreground;
            alternate-normal-background: @gruvbox-dark-bg1;
            alternate-normal-foreground: @foreground;
            selected-normal-background:  @gruvbox-dark-bg3;
            selected-normal-foreground:  @gruvbox-dark-fg0;

            active-background:           @gruvbox-dark-yellow-dark;
            active-foreground:           @background;
            alternate-active-background: @active-background;
            alternate-active-foreground: @active-foreground;
            selected-active-background:  @gruvbox-dark-yellow-light;
            selected-active-foreground:  @active-foreground;

            urgent-background:           @gruvbox-dark-red-dark;
            urgent-foreground:           @background;
            alternate-urgent-background: @urgent-background;
            alternate-urgent-foreground: @urgent-foreground;
            selected-urgent-background:  @gruvbox-dark-red-light;
            selected-urgent-foreground:  @urgent-foreground;
        }

        @import "gruvbox-common.rasi"
      '';

      home.file.".config/rofi/gruvbox-dark.rasi".text = ''
        /* ==========================================================================
           Rofi color theme

           Based on the Gruvbox color scheme for Vim by morhetz
           https://github.com/morhetz/gruvbox

           File: gruvbox-dark.rasi
           Desc: Gruvbox dark color theme for Rofi
           Author: bardisty <b@bah.im>
           Source: https://github.com/bardisty/gruvbox-rofi
           Modified: Mon Feb 12 2018 04:08:43 PST -0800
           ========================================================================== */

        * {
            /* Theme settings */
            highlight: bold italic;
            scrollbar: true;

            /* Gruvbox dark colors */
            gruvbox-dark-bg0:          #282828;
            gruvbox-dark-bg0-soft:     #32302f;
            gruvbox-dark-bg3:          #665c54;
            gruvbox-dark-fg0:          #fbf1c7;
            gruvbox-dark-fg1:          #ebdbb2;
            gruvbox-dark-red-dark:     #cc241d;
            gruvbox-dark-red-light:    #fb4934;
            gruvbox-dark-yellow-dark:  #d79921;
            gruvbox-dark-yellow-light: #fabd2f;
            gruvbox-dark-gray:         #a89984;

            /* Theme colors */
            background:                  @gruvbox-dark-bg0;
            background-color:            @background;
            foreground:                  @gruvbox-dark-fg1;
            border-color:                @gruvbox-dark-gray;
            separatorcolor:              @border-color;
            scrollbar-handle:            @border-color;

            normal-background:           @background;
            normal-foreground:           @foreground;
            alternate-normal-background: @gruvbox-dark-bg0-soft;
            alternate-normal-foreground: @foreground;
            selected-normal-background:  @gruvbox-dark-bg3;
            selected-normal-foreground:  @gruvbox-dark-fg0;

            active-background:           @gruvbox-dark-yellow-dark;
            active-foreground:           @background;
            alternate-active-background: @active-background;
            alternate-active-foreground: @active-foreground;
            selected-active-background:  @gruvbox-dark-yellow-light;
            selected-active-foreground:  @active-foreground;

            urgent-background:           @gruvbox-dark-red-dark;
            urgent-foreground:           @background;
            alternate-urgent-background: @urgent-background;
            alternate-urgent-foreground: @urgent-foreground;
            selected-urgent-background:  @gruvbox-dark-red-light;
            selected-urgent-foreground:  @urgent-foreground;
        }

        @import "gruvbox-common.rasi"

      '';

      home.file.".config/rofi/gruvbox-common.rasi".text = ''
            /* ==========================================================================
           File: gruvbox-common.rasi
           Desc: Shared rules between all gruvbox themes
           Author: bardisty <b@bah.im>
           Source: https://github.com/bardisty/gruvbox-rofi
           Modified: Mon Feb 12 2018 06:06:47 PST -0800
           ========================================================================== */

        window {
            background-color: @background;
            border:           2;
            padding:          2;
        }

        mainbox {
            border:  0;
            padding: 0;
        }

        message {
            border:       2px 0 0;
            border-color: @separatorcolor;
            padding:      1px;
        }

        textbox {
            highlight:  @highlight;
            text-color: @foreground;
        }

        listview {
            border:       2px solid 0 0;
            padding:      2px 0 0;
            border-color: @separatorcolor;
            spacing:      2px;
            scrollbar:    @scrollbar;
        }

        element {
            border:  0;
            padding: 2px;
        }

        element.normal.normal {
            background-color: @normal-background;
            text-color:       @normal-foreground;
        }

        element.normal.urgent {
            background-color: @urgent-background;
            text-color:       @urgent-foreground;
        }

        element.normal.active {
            background-color: @active-background;
            text-color:       @active-foreground;
        }

        element.selected.normal {
            background-color: @selected-normal-background;
            text-color:       @selected-normal-foreground;
        }

        element.selected.urgent {
            background-color: @selected-urgent-background;
            text-color:       @selected-urgent-foreground;
        }

        element.selected.active {
            background-color: @selected-active-background;
            text-color:       @selected-active-foreground;
        }

        element.alternate.normal {
            background-color: @alternate-normal-background;
            text-color:       @alternate-normal-foreground;
        }

        element.alternate.urgent {
            background-color: @alternate-urgent-background;
            text-color:       @alternate-urgent-foreground;
        }

        element.alternate.active {
            background-color: @alternate-active-background;
            text-color:       @alternate-active-foreground;
        }

        scrollbar {
            width:        4px;
            border:       0;
            handle-color: @scrollbar-handle;
            handle-width: 8px;
            padding:      0;
        }

        sidebar {
            border:       2px 0 0;
            border-color: @separatorcolor;
        }

        inputbar {
            spacing:    0;
            text-color: @normal-foreground;
            padding:    2px;
            children:   [ prompt, textbox-prompt-sep, entry, case-indicator ];
        }

        case-indicator,
        entry,
        prompt,
        button {
            spacing:    0;
            text-color: @normal-foreground;
        }

        button.selected {
            background-color: @selected-normal-background;
            text-color:       @selected-normal-foreground;
        }

        textbox-prompt-sep {
            expand:     false;
            str:        ":";
            text-color: @normal-foreground;
            margin:     0 0.3em 0 0;
        }

      '';

      home.file.".config/rofi/gruvbox-material.rasi".text = ''
        /**
         * Gruvbox rofi theme
         *
         * Color palette imported from https://github.com/sainnhe/gruvbox-material
         *
         */

        * {
        	gruv0: #282828;
        	gruv1: #32302f;
        	gruv2: #45403d;
        	gruv3: #5a524c;

        	gruv4: #fbf1c7;
        	gruv5: #f4e8be;
        	gruv6: #eee0b7;

        	gruv7: #a89984;
        	gruv8: #928374;
        	gruv9: #7c6f64;
        	gruv10: #504945;
        	red: #ea6962;

        	orange: #e78a4e;
        	yellow: #d8a657;
        	aqua: #89b482;
        	purple: #d3869b;

            reddark: #c14a4a;
            yellowdark: #b47109;

            foreground:  @gruv9;
            background-color:  transparent;

            highlight: underline bold #eee0b7;

            transparent: rgba(46,52,64,0);

        }

        window {
            location: center;
            anchor:   center;
            border-radius: 10px;
            height: 560px;
            width: 600px;

            background-color: @transparent;
            spacing: 0;
            children:  [mainbox];
            orientation: horizontal;
        }

        mainbox {
            spacing: 0;
            children: [ inputbar, message, listview ];
        }

        message {
            padding: 10px;
            border:  0px 2px 2px 2px;
            border-color: @gruv0;
            background-color: @gruv7;
        }

        inputbar {
            color: @gruv6;
            padding: 14px;
            background-color: @gruv0;
            border-color: @gruv0;

            border: 1px;
            border-radius: 10px 10px 0px 0px;
        }

        entry, prompt, case-indicator {
            text-font: inherit;
            text-color: inherit;
        }

        prompt {
            margin: 0px 1em 0em 0em ;
        }

        listview {
            padding: 8px;
            border-radius: 0px 0px 10px 10px;
            border: 2px 2px 2px 2px;
            border-color: @gruv0;
            background-color: @gruv0;
            dynamic: false;
        }

        element {
            padding: 5px;
            vertical-align: 0.5;
            border-radius: 10px;
            color: @foreground;
            text-color: @gruv6;
            background-color: @gruv1;
        }

        element.normal.active {
            background-color: @yellow;
        }

        element.normal.urgent {
            background-color: @reddark;
        }

        element.selected.normal {
            background-color: @gruv7;
            text-color: @gruv0;
        }

        element.selected.active {
            background-color: @yellowdark;
        }

        element.selected.urgent {
            background-color: @red;
        }

        element.alternate.normal {
            background-color: @transparent;
        }

        element-text, element-icon {
            size: 3ch;
            margin: 0 10 0 0;
            vertical-align: 0.5;
            background-color: inherit;
            text-color: @gruv6;
        }

        button {
            padding: 6px;
            color: @foreground;
            horizontal-align: 0.5;

            border: 2px 0px 2px 2px;
            border-radius: 10px;
            border-color: @foreground;
        }

        button.selected.normal {
            border: 2px 0px 2px 2px;
            border-color: @foreground;
        }
      '';

      programs.rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
        cycle = true;
        font = "Liga SFMono Nerd Font 16";
        terminal = "${pkgs.alacritty}/bin/alacritty";
        theme."@import" = "${user-settings.user.home}/.config/rofi/gruvbox-material.rasi";
        extraConfig = {
          show-icons = true;
          icon-theme = "GruvboxPlus";
          #   display-ssh = "󰣀 ssh:";
          # display-run = "󱓞 run:";
          # display-drun = "󰣖 drun:";
          # display-window = "󱂬 window:";
          # display-combi = "󰕘 combi:";
          # display-filebrowser = "󰉋 filebrowser:";

          # dpi =  120;
        };

      };
    };
  };
}
