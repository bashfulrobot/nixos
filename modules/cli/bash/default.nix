{ user-settings, config, lib, pkgs, ... }:
let
  cfg = config.cli.bash;
  fd-flags = lib.concatStringsSep " " [ "--hidden" "--exclude '.git'" ];

in {

  options = {
    cli.bash.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the bash shell.";
    };
  };

  config = lib.mkIf cfg.enable {

    home-manager.users."${user-settings.user.username}" = {
      home.packages = with pkgs;
        [
          bash-completion # bash shell completion
        ];

      programs.bash = {
        enable = true;
        historyControl = [ "ignoredups" "ignorespace" ];
        bashrcExtra = ''
          # dir name only to cd
          shopt -s autocd
          # autofix dir typos
          shopt -s cdspell
          # shopt -s direxpand dirspell # home  manager reports as invalid
          # Enable the ** globstar recursive pattern in file and directory expansions.
          # For example, ls **/*.txt will list all text files in the current directory hierarchy.
          shopt -s globstar
          HISTIGNORE=?:??
          HISTFILESIZE=99999
          HISTSIZE=99999
          shopt -s histappend
        '';

        shellAliases = {
          ".." = "cd ..";
          "..." = "cd ../..";
          "...." = "cd ../../..";
          "....." = "cd ../../../..";
          tf = "terraform";
          instruqt = "/home/${user-settings.user.username}/dev/sysdig/workshops/bin/instruqt";
          ipull =
            "cd ~/dev/sysdig/workshops/instruqt/tracks/monitor/troubleshooting-essentials-with-advisor/; /home/${user-settings.user.username}/dev/sysdig/workshops/bin/instruqt track pull";
          ipush =
            "cd ~/dev/sysdig/workshops/instruqt/tracks/monitor/troubleshooting-essentials-with-advisor/; /home/${user-settings.user.username}/dev/sysdig/workshops/bin/instruqt track push";
          ilog =
            "cd ~/dev/sysdig/workshops/instruqt/tracks/monitor/troubleshooting-essentials-with-advisor/; /home/${user-settings.user.username}/dev/sysdig/workshops/bin/instruqt track logs";
          y = "cd ~/; yazi";
          e = "lvim";
          nvim = "lvim";
          vi = "lvim";
          vim = "lvim";
          ny = "cd ~/dev/nix/nixos/; yazi";
          n = "cd ~/dev/nix/nixos/; lvim";
          nc =
            "cd ~/dev/nix/nixos && git add . && git commit -S && rebuild && git push";
          ls = "${pkgs.eza}/bin/eza -al --octal-permissions --icons";
          # ls = "${pkgs.eza}/bin/eza -al --octal-permissions";
          font-cache-refresh = "sudo fc-cache -f -v";
          font-list = "fc-list";
          cat = "${pkgs.bat}/bin/bat";
          grep = "${pkgs.ripgrep}/bin/rg";
          du = "${pkgs.du-dust}/bin/dust";
          ps = "${pkgs.procs}/bin/procs";
          man = "${pkgs.tealdeer}/bin/tldr";
          top = "${pkgs.bottom}/bin/btm";
          htop = "${pkgs.bottom}/bin/btm";
          #sed = "${pkgs.sd}/bin/sd";
          k = "${pkgs.kubecolor}/bin/kubecolor";
          kubectl = "${pkgs.kubecolor}/bin/kubecolor";
          dc = "${pkgs.docker}/bin/docker compose";
          ping = "${pkgs.gping}/bin/gping";
          j = "${pkgs.just}/bin/just --choose --unsorted";
          nixcfg = "${pkgs.man}/bin/man configuration.nix";
          hmcfg = "${pkgs.man}/bin/man home-configuration.nix";
          rustscan =
            "${pkgs.docker}/bin/docker run -it --rm --name rustscan rustscan/rustscan:latest";
          kcfg = "cd ~/.kube && ${pkgs.just}/bin/just && cd -";
          kns = "${pkgs.kubectx}/bin/kubens";
          kc = "${pkgs.kubectx}/bin/kubectx";
          vms = "sudo ${pkgs.libvirt}/bin/virsh list --all";
          yless = "${pkgs.jless}/bin/jless --yaml";
          # please = "${pkgs.shell-genie}/bin/shell-genie ask";
          rebuild =
            "echo;echo '***** UPDATE APPIMAGES PERIODIALLY *****'; echo;  sleep 1; cd ~/dev/nix/nixos/; ${pkgs.just}/bin/just rebuild; cd -";
          upgrade =
            "cd ~/dev/nix/nixos/; ${pkgs.just}/bin/just upgrade-system; cd -";
          dev-rebuild =
            "cd ~/dev/nix/nixos/; ${pkgs.just}/bin/just dev-rebuild; cd -";
          kubitect =
            "${pkgs.steam-run}/bin/steam-run /etc/profiles/per-user/${user-settings.user.username}/bin/kubitect";
          comics-downloader =
            "${pkgs.steam-run}/bin/steam-run /etc/profiles/per-user/${user-settings.user.username}/bin/comics-downloader";
          gc = "git pull && git add . && git commit -S && git push";
        };

      };

      home.file.".inputrc".text = ''
        # https://bluz71.github.io/2018/03/15/bash-shell-tweaks-tips.html
        $include /etc/inputrc
        TAB: menu-complete
        "\e[Z": menu-complete-backward
        set menu-complete-display-prefix on
        set show-all-if-ambiguous on
        set colored-stats on
        set colored-completion-prefix on
        set completion-ignore-case on
        set completion-map-case on
        set mark-symlinked-directories on
        "\e[A":history-search-backward
        "\e[B":history-search-forward
        set page-completions off
        set completion-query-items 200
        set echo-control-characters off

      '';

      programs.fzf = {
        enable = true;
        enableBashIntegration = true;
        defaultCommand = "fd --type f ${fd-flags}";
        fileWidgetCommand = "fd --type f ${fd-flags}";
        changeDirWidgetCommand = "fd --type d ${fd-flags}";
      };

      # programs.atuin = {
      #   enable = false;
      #   enableBashIntegration = false;
      #   settings = {
      #     auto_sync = true;
      #     sync_frequency = "5m";
      #     sync_address = "https://api.atuin.sh";
      #     search_mode = "prefix";
      #   };
      # };
    };
  };
}
