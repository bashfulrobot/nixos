# Espanso on nix is a problem. Breaks frequently. This is a workaround to get it working.
# https://github.com/ingbarrozo/espanso
{ user-settings, pkgs, config, lib, ... }:
let
  cfg = config.cli.espanso;

in {
  options = {
    cli.espanso.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Espanso.";
    };
  };

  config = lib.mkIf cfg.enable {

    # Add user to input group
    users.users."${user-settings.user.username}".extraGroups = [ "input" ];
    services.espanso.enable = true;

    home-manager.users."${user-settings.user.username}" = {

      imports = [ ./ingbarrozo/espanso/build ];

      # Comes from the custom module in modules/cli/espanso/ingbarrozo/espanso
      programs.espanso.enable = true;

      home.file.".config/espanso/config/default.yml".text = ''
        # Automatically generated by espanso migration tool
        # Original file: default.yml

        keyboard_layout:
          layout: "us"
      '';
      home.file.".config/espanso/match/base.yml".text = ''
        matches:
            - trigger: "_noarch"
              replace: "Well, actually I do NOT use Arch, I run NixOS - (╯°□°）╯︵ ┻━┻"
      '';

      home.file.".config/espanso/match/c920cam.yml".text = ''
        matches:
            - trigger: "_zm"
              replace: v4l2-ctl -d /dev/video0 --set-ctrl zoom_absolute=
            - trigger: "_br"
              replace: v4l2-ctl -d /dev/video0 --set-ctrl brightness=
            - trigger: "_sat"
              replace: v4l2-ctl -d /dev/video0 --set-ctrl saturation=160
      '';

      home.file.".config/espanso/match/cmd.yml".text = ''
        matches:
            - trigger: "_pip"
              replace: "{{output}}"
              vars:
                - name: output
                  type: shell
                  params:
                    cmd: "curl -s 'https://api.ipify.org'"
                    shell: bash
      '';

      home.file.".config/espanso/match/date.yml".text = ''
        matches:
            - trigger: "_date"
              replace: "{{mydate}}"
              vars:
                - name: mydate
                  type: date
                  params:
                      format: "%Y-%m-%d"
            - trigger: "_7d"
              replace: "{{output}}"
              vars:
                  - name: output
                    type: shell
                    params:
                        cmd: "date +%F -d '+7 days'"
            - trigger: "_2h"
              replace: "{{output}}"
              vars:
                  - name: output
                    type: shell
                    params:
                      cmd: "date +%F -d '+2 hours'"
      '';

      home.file.".config/espanso/match/emoji.yml".text = ''
        matches:
            - trigger: "_lk"
              replace: 👀
            - trigger: "_sm"
              replace: 🙂
            - trigger: "_fu"
              replace: 🖕
            - trigger: "_th"
              replace: 👍
            - trigger: "_cry"
              replace: 😭
            - trigger: "_up"
              replace: 👆
            - trigger: "_fp"
              replace: 🤦
            - trigger: "_po"
              replace: 🤔
            - trigger: "_rol"
              replace: 🤣
      '';

      home.file.".config/espanso/match/git.yml".text = ''
        matches:
          - trigger: "_gcb"
            replace: 'fix: :bug: $|$'
          - trigger: "_gcd"
            replace: 'docs: :memo: $|$'
          - trigger: "_gcr"
            replace: 'refactor: :recycle: $|$'
          - trigger: "_gcf"
            replace: 'feat: :sparkles: $|$'
          - trigger: "_gcc"
            replace: 'chore: :art: $|$'
          - trigger: "_gci"
            replace: 'chore: :tada: Initial Commit $|$'
          - trigger: "_gcv"
            replace: 'chore: :pushpin: Initial Commit $|$'

      '';

      home.file.".config/espanso/match/media.yml".text = ''
        matches:
          - trigger: "_feral"
            replace: 'lftp -u msgedme aether.feralhosting.com -e "cd /media/sdac1/msgedme/private/deluge/data/"'
          - trigger: "_path"
            replace: '/media/sdac1/msgedme/private/deluge/data/dl'
      '';

      home.file.".config/espanso/match/spelling.yml".text = ''
        matches:
            - trigger: hte
              replace: the
              word: true
            - trigger: teh
              replace: the
              word: true
            - trigger: donlt
              replace: "don't"
              word: true
            - trigger: befoire
              replace: before
              word: true
            - trigger: finially
              replace: finally
              word: true
      '';

      home.file.".config/espanso/match/tmux.yml".text = ''
        matches:
          - trigger: "_sync"
            replace: setw synchronize-panes on
          - trigger: "_unsync"
            replace: setw synchronize-panes off
      '';

    };

  };

}
