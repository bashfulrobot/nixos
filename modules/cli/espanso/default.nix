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

      home.file.".config/espanso/match/ascii.yml".text = ''
        matches:
            - trigger: "#shrug"
              replace: ¯\\_(ツ)_/¯
            - trigger: "#flip"
              replace: (╯°□°）╯︵ ┻━┻
            - trigger: "#unflip"
              replace: ┬──┬ ノ( ゜-゜ノ)
            - trigger: "#lenny"
              replace: ( ͡° ͜ʖ ͡°)
      '';

      home.file.".config/espanso/match/base.yml".text = ''
        matches:
            - trigger: "#noarch"
              replace: "Well, actually I do NOT use Arch, I run NixOS - (╯°□°）╯︵ ┻━┻"
      '';

      home.file.".config/espanso/match/c920cam.yml".text = ''
        matches:
            - trigger: "#zm"
              replace: v4l2-ctl -d /dev/video0 --set-ctrl zoom_absolute=
            - trigger: "#br"
              replace: v4l2-ctl -d /dev/video0 --set-ctrl brightness=
            - trigger: "#sat"
              replace: v4l2-ctl -d /dev/video0 --set-ctrl saturation=160
      '';

      home.file.".config/espanso/match/cmd.yml".text = ''
        matches:
            - trigger: "#pip"
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
            - trigger: "#date"
              replace: "{{mydate}}"
              vars:
                - name: mydate
                  type: date
                  params:
                      format: "%Y-%m-%d"
            - trigger: "#7d"
              replace: "{{output}}"
              vars:
                  - name: output
                    type: shell
                    params:
                        cmd: "date +%F -d '+7 days'"
            - trigger: "#2h"
              replace: "{{output}}"
              vars:
                  - name: output
                    type: shell
                    params:
                      cmd: "date +%F -d '+2 hours'"
      '';

      home.file.".config/espanso/match/emoji.yml".text = ''
        matches:
            - trigger: "#lk"
              replace: 👀
            - trigger: "#sm"
              replace: 🙂
            - trigger: "#fu"
              replace: 🖕
            - trigger: "#th"
              replace: 👍
            - trigger: "#cry"
              replace: 😭
            - trigger: "#up"
              replace: 👆
            - trigger: "#fp"
              replace: 🤦
            - trigger: "#po"
              replace: 🤔
            - trigger: "#rol"
              replace: 🤣
      '';

      home.file.".config/espanso/match/git.yml".text = ''
        matches:
          - trigger: "#gcb"
            replace: 'fix: :bug: $|$'
          - trigger: "#gcd"
            replace: 'docs: :memo: $|$'
          - trigger: "#gcr"
            replace: 'refactor: :recycle: $|$'
          - trigger: "#gcf"
            replace: 'feat: :sparkles: $|$'
          - trigger: "#gcc"
            replace: 'chore: :art: $|$'
          - trigger: "#gci"
            replace: 'chore: :tada: Initial Commit $|$'
          - trigger: "#gcv"
            replace: 'chore: :pushpin: Initial Commit $|$'

      '';

      home.file.".config/espanso/match/media.yml".text = ''
        matches:
          - trigger: "#feral"
            replace: 'lftp -u msgedme aether.feralhosting.com -e "cd /media/sdac1/msgedme/private/deluge/data/"'
          - trigger: "#dl"
            replace: MYFILEBOT="/home/dustin/docker/filebot" && cd $MYFILEBOT && rsync --progress -avze ssh feral:/media/sdac1/msgedme/private/deluge/data/dl/ ./process
          - trigger: "#rnt"
            replace: 'MYFILEBOT="/home/dustin/docker/filebot"&& MYPLEX="/home/dustin/docker/plex" && cd $MYFILEBOT && docker run --rm -it -v $MYFILEBOT/process:/process -v $MYPLEX:/media -v data:/data rednoah/filebot -r -rename /process --format "{plex}" --db thetvdb --lang en --action copy --conflict override --output /media -non-strict && sudo chown -R dustin:dustin $MYPLEX/TV*'
          - trigger: "#rnm"
            replace: 'MYFILEBOT="/home/dustin/docker/filebot";MYPLEX="/home/dustin/docker/plex";cd $MYFILEBOT; docker run --rm -it -v $MYFILEBOT/process:/process -v $MYPLEX:/media -v data:/data rednoah/filebot -r -rename /process --format "{plex}" --db themoviedb --lang en --action copy --conflict override --output /media -non-strict; sudo chown -R dustin:dustin $MYPLEX/Movies'
          - trigger: "#gtv"
            replace: 'clear && echo "Getting Files" && echo && MYFILEBOT="/home/dustin/docker/filebot" && MYPLEX="/home/dustin/docker/plex" && cd $MYFILEBOT && rsync --progress -avze ssh feral:/media/sdac1/msgedme/private/deluge/data/dl/ ./process && echo && echo "Renaming Files" && echo && docker run --rm -it -v $MYFILEBOT/process:/process -v $MYPLEX:/media -v data:/data rednoah/filebot -r -rename /process --format "{plex}" --db thetvdb --lang en --action copy --conflict override --output /media -non-strict && echo && echo "Setting Permissions" && echo && sudo chown -R dustin:dustin $MYPLEX/TV* && MYFILEBOT="/home/dustin/docker/filebot" && echo "Deleting Files" && echo && rm -rf $MYFILEBOT/process/*'
          - trigger: "#gm"
            replace: 'clear && echo "Getting Files" && echo && MYFILEBOT="/home/dustin/docker/filebot" && MYPLEX="/home/dustin/docker/plex" && cd $MYFILEBOT && rsync --progress -avze ssh feral:/media/sdac1/msgedme/private/deluge/data/dlm/ ./process-m && echo && echo "Renaming Files" && echo && docker run --rm -it -v $MYFILEBOT/process-m:/process-m -v $MYPLEX:/media -v data:/data rednoah/filebot -r -rename /process-m --format "{plex}" --db themoviedb --lang en --action copy --conflict override --output /media -non-strict && echo && echo "Setting Permissions" && echo && sudo chown -R dustin:dustin $MYPLEX/Movies && MYFILEBOT="/home/dustin/docker/filebot" && echo "Deleting Files" && echo && rm -rf $MYFILEBOT/process-m/*'
          - trigger: "#path"
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
          - trigger: "#sync"
            replace: setw synchronize-panes on
          - trigger: "#unsync"
            replace: setw synchronize-panes off
      '';

    };

  };

}
