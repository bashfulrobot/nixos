# https://github.com/budimanjojo/dotfiles
{ user-settings, pkgs, config, lib, inputs, ... }:
let

  cfg = config.desktops.hyprland.config.window-rules;

in {

  options = {
    desktops.hyprland.config.window-rules.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Hyprland Window Rules";
    };
  };
  config = lib.mkIf cfg.enable {

    ##### Home Manager Config options #####
    home-manager.users."${user-settings.user.username}" = {

      wayland.windowManager = {
        hyprland = {
          settings = {
            #  Window Rules

            windowrulev2 = [
              # only allow shadows for floating windows
              "noshadow, floating:0"

              "float, class:^(1Password)$"
              "stayfocused,title:^(Quick Access — 1Password)$"
              "dimaround,title:^(Quick Access — 1Password)$"
              "noanim,title:^(Quick Access — 1Password)$"

              # Window floating and layout
              "float, class:^(pavucontrol)$"
              "float, class:^(obs)$"
              "float, class:^(gnome-calculator|org.gnome.Calculator)$"
              "float, class:^(pamac-manager)$"
              "float, class:^(eog)$"
              "float, class:^(blueman-manager)$"
              "float, class:^(nm-connection-editor)$"
              "float, title:^(File Transfer*)$"
              "idleinhibit focus, fullscreen:1"

              # Window placement
              "workspace 5, class:^(smplayer)$"
              "workspace 7, class:^(Gimp)$"
              "workspace 9, class:^(obs)$"

              # only allow shadows for floating windows
              "noshadow, floating:0"

              # idle inhibit while watching videos
              "idleinhibit focus, class:^(mpv|.+exe)$"
              "idleinhibit fullscreen, class:.*"

              # make Firefox PiP window floating and sticky
              "float, title:^(Picture-in-Picture)$"
              "pin, title:^(Picture-in-Picture)$"

              "float, class:^(1Password)$"
              "stayfocused,title:^(Quick Access — 1Password)$"
              "dimaround,title:^(Quick Access — 1Password)$"
              "noanim,title:^(Quick Access — 1Password)$"

              "float, class:^(org.gnome.*)$"
              "float, class:^(pavucontrol)$"
              "float, class:(blueberry.py)"

              # make pop-up file dialogs floating, centred, and pinned
              "float, title:(Open|Progress|Save File)"
              "center, title:(Open|Progress|Save File)"
              "pin, title:(Open|Progress|Save File)"
              "float, class:^(code)$"
              "center, class:^(code)$"
              "pin, class:^(code)$"

              # assign windows to workspaces
              # "workspace 1 silent, class:[Ff]irefox"
              # "workspace 2 silent, class:[Oo]bsidian"
              # "workspace 2 silent, class:google-chrome"
              # "workspace 2 silent, class:[Rr]ambox"
              # "workspace 1 silent, class:[Ss]ignal"
              # "workspace 5 silent, class:code-url-handler"

              # throw sharing indicators away
              "workspace special silent, title:^(Firefox — Sharing Indicator)$"
              "workspace special silent, title:^(.*is sharing (your screen|a window).)$"
            ];

          };

        };

      };
    };
  };
}
