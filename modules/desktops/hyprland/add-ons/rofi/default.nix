{ user-settings, pkgs, config, lib, inputs, system, ... }:
with lib;
let
  cfg = config.desktops.hyprland.add-ons.rofi;
  # from user-settings
  theme = user-settings.theme.CatppuccinMacchiato;
in {
  options.desktops.hyprland.add-ons.rofi.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable rofi for hyprland";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [
        #waybar-clock-hover
      ];

    home-manager.users.${user-settings.user.username} = {
      programs.rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
        extraConfig = {
          # font = "UbuntuMono Nerd Font 12";
          font = "Liga SFMono Nerd Font 16";
          display-drun = " ";
          show-icons = true;
          drun-display-format = "{name}";
          disable-history = false;
          sidebar-mode = false;
        };
        # TODO: Bring theme inline so I can use user-settings for colours
        # theme = ./build/cfg/style.rasi;
        theme = builtins.toFile "style.rasi" ''
          * {
            selected-normal-foreground:  ${theme.background};
            foreground:                  ${theme.foreground};
            normal-foreground:           @foreground;
            alternate-normal-background: @background;
            selected-urgent-foreground:  @selected-normal-foreground;
            urgent-foreground:           @selected-normal-foreground;
            alternate-urgent-background: @selected-normal-background;
            active-foreground:           ${theme.foreground};
            selected-active-foreground:  @active-foreground;
            alternate-active-background: ${theme.background};
            background:                  ${theme.background};
            alternate-normal-foreground: @foreground;
            normal-background:           @background;
            selected-normal-background:  ${theme.active};
            spacing:                     2px;
            separatorcolor:              ${theme.foreground};
            urgent-background:           ${theme.error};
            selected-urgent-background:  @selected-normal-background;
            alternate-urgent-foreground: @urgent-foreground;
            background-color:            @background;
            alternate-active-foreground: @active-foreground;
            active-background:           @background;
            selected-active-background:  @selected-normal-background;
            prompt-foreground:           ${theme.error};
          }

          #window {
            background-color: @background;
            border-color: @separatorcolor;
            border: 1px;
            border-radius: 5px;
            padding: 5px;
            width: 25%;
          }

          #mainbox {
            border: 0;
            padding: 2px;
          }

          #message {
            border: 2px 0px 0px;
            border-color: @separatorcolor;
            padding: 1px;
          }

          #textbox {
            text-color: @foreground;
          }

          #listview {
            fixed-height: 0;
            border: 1px 0px 0px ;
            border-color: @separatorcolor;
            spacing: 5px;
            scrollbar: false;
            padding: 10px 0px 0px ;
            lines: 10;
          }

          #element {
            border: 0;
            padding: 3px;
            cursor: pointer;
            spacing: 5px;
          }

          #element.normal.normal {
            background-color: @normal-background;
            text-color: @normal-foreground;
          }
          #element.normal.urgent {
            background-color: @urgent-background;
            text-color: @urgent-foreground;
          }
          #element.normal.active {
            background-color: @active-background;
            text-color: @active-foreground;
          }
          #element.selected.normal {
            background-color: @selected-normal-background;
            text-color: @selected-normal-foreground;
          }
          #element.selected.urgent {
            background-color: @selected-urgent-background;
            text-color: @selected-urgent-foreground;
          }
          #element.selected.active {
            background-color: @selected-active-background;
            text-color: @selected-active-foreground;
          }
          #element.alternate.normal {
            background-color: @alternate-normal-background;
            text-color: @alternate-normal-foreground;
          }
          #element.alternate.urgent {
            background-color: @alternate-urgent-background;
            text-color: @alternate-urgent-foreground;
          }
          #element.alternate.active {
            background-color: @alternate-active-background;
            text-color: @alternate-active-foreground;
          }

          #element-text {
            background-color: transparent;
            cursor: inherit;
            highlight: inherit;
            text-color: inherit;
          }

          #element-icon {
            background-color: transparent;
            size: 1em;
            cursor: inherit;
            text-color: inherit;
          }

          #scrollbar {
            width: 4px ;
            border: 0;
            handle-width: 8px ;
            padding: 0;
            handle-color: var(normal-foreground);
          }

          #sidebar {
            border-color: @separatorcolor;
            border: 2px dash 0 0;
          }

          #mode-switcher {
            border: 2px 0px 0px ;
            border-color: @separatorcolor;
          }

          #button {
            cursor: pointer;
            spacing: 0;
            text-color: @normal-foreground;
          }

          #button.selected {
            background-color: @selected-normal-background;
            text-color: @selected-normal-foreground;
          }

          #inputbar {
            spacing: 5px;
            text-color: @normal-foreground;
            padding: 3px ;
          }

          #case-indicator {
            spacing: 0;
            text-color: @normal-foreground;
          }

          #entry {
            spacing: 0;
            text-color: @normal-foreground;
          }

          #prompt {
            spacing: 0;
            text-color: @prompt-foreground;
          }

          #textbox-prompt-colon {
            expand: false;
            str: ":";
            text-color: @prompt-foreground;
          }

          #inputbar {
            children: [prompt,entry,case-indicator];
          }
        '';
      };
    };
  };
}
