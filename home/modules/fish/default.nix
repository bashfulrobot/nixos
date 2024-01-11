{ config, lib, pkgs, ... }:
let fd-flags = lib.concatStringsSep " " [ "--hidden" "--exclude '.git'" ];
in {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    # plugins = [
    #   # Enable a plugin (here grc for colorized command output) from nixpkgs
    #   {
    #     name = "grc";
    #     src = pkgs.fishPlugins.grc.src;
    #   }
    #   # Manually packaging and enable a plugin
    #   {
    #     name = "z";
    #     src = pkgs.fetchFromGitHub {
    #       owner = "jethrokuan";
    #       repo = "z";
    #       rev = "e0e1b9dfdba362f8ab1ae8c1afc7ccf62b89f7eb";
    #       sha256 = "0dbnir6jbwjpjalz14snzd3cgdysgcs3raznsijd6savad3qhijc";
    #     };
    #   }
    # ];
    functions = {
      shutdown_all_local_vms = ''
        function shutdown_all_vms {
          local domains=$(virsh list --name --state-running)
          if [[ -z "$domains" ]]; then
            echo '{{ Color "99" "0" "No running VMs detected." }} :disappointed:' | gum format -t template | gum format -t emoji
          else
            echo '{{ Bold "Shutting down the following VMs:" }} :arrow_down:' | gum format -t template | gum format -t emoji
            for domain in $domains
            do
              echo '{{ Italic "Shutting down" }} $domain... :hourglass_flowing_sand:' | gum format -t template | gum format -t emoji
              virsh shutdown $domain
              if [[ $? -eq 0 ]]; then
                echo '$domain {{ Bold "has been shut down successfully." }} :thumbsup:' | gum format -t template | gum format -t emoji
              else
                echo '{{ Color "99" "0" "Failed to shut down" }} $domain. :thumbsdown:' | gum format -t template | gum format -t emoji
              fi
            done
          fi
        }
      '';
    };
    shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      tf = "terraform";
      instruqt = "/home/dustin/dev/sysdig/workshops/bin/instruqt";
      ipull =
        "cd ~/dev/sysdig/workshops/instruqt/tracks/monitor/troubleshooting-essentials-with-advisor/; /home/dustin/dev/sysdig/workshops/bin/instruqt track pull";
      ipush =
        "cd ~/dev/sysdig/workshops/instruqt/tracks/monitor/troubleshooting-essentials-with-advisor/; /home/dustin/dev/sysdig/workshops/bin/instruqt track push";
      ilog =
        "cd ~/dev/sysdig/workshops/instruqt/tracks/monitor/troubleshooting-essentials-with-advisor/; /home/dustin/dev/sysdig/workshops/bin/instruqt track logs";
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
      j = "${pkgs.just}/bin/just --choose";
      nixcfg = "${pkgs.man}/bin/man configuration.nix";
      hmcfg = "${pkgs.man}/bin/man home-configuration.nix";
      rustscan =
        "${pkgs.docker}/bin/docker run -it --rm --name rustscan rustscan/rustscan:latest";
      kcfg = "cd ~/.kube && ${pkgs.just}/bin/just && cd -";
      kns = "${pkgs.kubectx}/bin/kubens";
      kc = "${pkgs.kubectx}/bin/kubectx";
      vms = "sudo ${pkgs.libvirt}/bin/virsh list --all";
      yless = "${pkgs.jless}/bin/jless --yaml";
      please = "${pkgs.shell-genie}/bin/shell-genie ask";
      rebuild =
        "echo;echo '***** UPDATE APPIMAGES PERIODIALLY *****'; echo;  sleep 1; cd ~/dev/nix/nixos/; ${pkgs.just}/bin/just rebuild; cd -";
      upgrade =
        "cd ~/dev/nix/nixos/; ${pkgs.just}/bin/just upgrade-system; cd -";
      dev-rebuild =
        "cd ~/dev/nix/nixos/; ${pkgs.just}/bin/just dev-rebuild; cd -";
      kubitect =
        "${pkgs.steam-run}/bin/steam-run /etc/profiles/per-user/dustin/bin/kubitect";
    };

  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    defaultCommand = "fd --type f ${fd-flags}";
    fileWidgetCommand = "fd --type f ${fd-flags}";
    changeDirWidgetCommand = "fd --type d ${fd-flags}";
  };

  programs.atuin = {
    enable = false;
    enableFishIntegration = false;
    settings = {
      auto_sync = true;
      sync_frequency = "5m";
      sync_address = "https://api.atuin.sh";
      search_mode = "prefix";
    };
  };

  home.packages = with pkgs; [
    fishPlugins.tide
    fishPlugins.grc
    grc
    fishPlugins.github-copilot-cli-fish
    fishPlugins.fzf-fish
    fishPlugins.colored-man-pages
    fishPlugins.bass
    fishPlugins.autopair
    # fishPlugins.async-prompt
    fishPlugins.done
    fishPlugins.forgit
    fishPlugins.sponge
  ];

  # home.file.".config/fish/match/fish_variables".text = ''
  #     # This file contains fish universal variable definitions.
  #   # VERSION: 3.0
  #   SETUVAR ZO_CMD:zo
  #   SETUVAR Z_CMD:z
  #   SETUVAR Z_DATA:/home/dustin/\x2elocal/share/z/data
  #   SETUVAR Z_DATA_DIR:/home/dustin/\x2elocal/share/z
  #   SETUVAR Z_EXCLUDE:\x5e/home/dustin\x24
  #   SETUVAR __fish_initialized:3400
  #   SETUVAR _tide_left_items:os\x1epwd\x1egit\x1enewline\x1echaracter
  #   SETUVAR _tide_prompt_64012:\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x5b38\x3b2\x3b88\x3b88\x3b88m\x1b\x5b38\x3b2\x3b238\x3b238\x3b238m\x1b\x5b48\x3b2\x3b88\x3b88\x3b88m\x20\uf313\x20\x1b\x5b38\x3b2\x3b148\x3b148\x3b148m\u2502\x1b\x5b48\x3b2\x3b88\x3b88\x3b88m\x20\x40PWD\x40\x20\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x5b38\x3b2\x3b88\x3b88\x3b88m\ue0bc\x1e\x1b\x5b38\x3b2\x3b95\x3b215\x3b0m\u276f\x1e\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x5b38\x3b2\x3b88\x3b88\x3b88m\ue0ba\x1b\x5b38\x3b2\x3b50\x3b108\x3b229m\x1b\x5b48\x3b2\x3b88\x3b88\x3b88m\x20\U000f10fe\x20admin\x40dt\x20\x1b\x5b38\x3b2\x3b148\x3b148\x3b148m\u2502\x1b\x5b38\x3b2\x3b95\x3b135\x3b135m\x1b\x5b48\x3b2\x3b88\x3b88\x3b88m\x2011\x3a15\x3a45\x20\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x5b38\x3b2\x3b88\x3b88\x3b88m
  #   SETUVAR _tide_prompt_64362:\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x5b38\x3b2\x3b88\x3b88\x3b88m\x1b\x5b38\x3b2\x3b238\x3b238\x3b238m\x1b\x5b48\x3b2\x3b88\x3b88\x3b88m\x20\uf313\x20\x1b\x5b38\x3b2\x3b148\x3b148\x3b148m\u2502\x1b\x5b48\x3b2\x3b88\x3b88\x3b88m\x20\x40PWD\x40\x20\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x5b38\x3b2\x3b88\x3b88\x3b88m\ue0bc\x1e\x1b\x5b38\x3b2\x3b95\x3b215\x3b0m\u276f\x1e\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x5b38\x3b2\x3b88\x3b88\x3b88m\ue0ba\x1b\x5b38\x3b2\x3b50\x3b108\x3b229m\x1b\x5b48\x3b2\x3b88\x3b88\x3b88m\x20\U000f10fe\x20admin\x40dt\x20\x1b\x5b38\x3b2\x3b148\x3b148\x3b148m\u2502\x1b\x5b38\x3b2\x3b95\x3b135\x3b135m\x1b\x5b48\x3b2\x3b88\x3b88\x3b88m\x2011\x3a15\x3a16\x20\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x5b38\x3b2\x3b88\x3b88\x3b88m
  #   SETUVAR _tide_prompt_64763:\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x5b38\x3b2\x3b88\x3b88\x3b88m\x1b\x5b38\x3b2\x3b238\x3b238\x3b238m\x1b\x5b48\x3b2\x3b88\x3b88\x3b88m\x20\uf313\x20\x1b\x5b38\x3b2\x3b148\x3b148\x3b148m\u2502\x1b\x5b48\x3b2\x3b88\x3b88\x3b88m\x20\x40PWD\x40\x20\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x5b38\x3b2\x3b88\x3b88\x3b88m\ue0bc\x1e\x1b\x5b38\x3b2\x3b95\x3b215\x3b0m\u276f\x1e\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x5b38\x3b2\x3b88\x3b88\x3b88m\ue0ba\x1b\x5b38\x3b2\x3b50\x3b108\x3b229m\x1b\x5b48\x3b2\x3b88\x3b88\x3b88m\x20\U000f10fe\x20admin\x40dt\x20\x1b\x5b38\x3b2\x3b148\x3b148\x3b148m\u2502\x1b\x5b38\x3b2\x3b95\x3b135\x3b135m\x1b\x5b48\x3b2\x3b88\x3b88\x3b88m\x2011\x3a15\x3a35\x20\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x5b38\x3b2\x3b88\x3b88\x3b88m
  #   SETUVAR _tide_prompt_6681:\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x5b38\x3b2\x3b88\x3b88\x3b88m\x1b\x5b38\x3b2\x3b238\x3b238\x3b238m\x1b\x5b48\x3b2\x3b88\x3b88\x3b88m\x20\uf313\x20\x1b\x5b38\x3b2\x3b148\x3b148\x3b148m\ue0b1\x1b\x5b48\x3b2\x3b88\x3b88\x3b88m\x20\x40PWD\x40\x20\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x5b38\x3b2\x3b88\x3b88\x3b88m\ue0b0\x1e\x1b\x5b38\x3b2\x3b95\x3b215\x3b0m\u276f\x1e\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x5b38\x3b2\x3b88\x3b88\x3b88m\ue0b2\x1b\x5b38\x3b2\x3b135\x3b135\x3b95m\x1b\x5b48\x3b2\x3b88\x3b88\x3b88m\x20\uf252\x207s\x20\x1b\x5b38\x3b2\x3b148\x3b148\x3b148m\ue0b3\x1b\x5b38\x3b2\x3b50\x3b108\x3b229m\x1b\x5b48\x3b2\x3b88\x3b88\x3b88m\x20\U000f10fe\x20admin\x40dt\x20\x1b\x5b38\x3b2\x3b148\x3b148\x3b148m\ue0b3\x1b\x5b38\x3b2\x3b95\x3b135\x3b135m\x1b\x5b48\x3b2\x3b88\x3b88\x3b88m\x2011\x3a27\x3a44\x20\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x5b38\x3b2\x3b88\x3b88\x3b88m
  #   SETUVAR _tide_right_items:status\x1ecmd_duration\x1econtext\x1ejobs\x1enode\x1epython\x1ego\x1egcloud\x1ekubectl\x1eterraform\x1eaws\x1enix_shell\x1etime
  #   SETUVAR fish_color_autosuggestion:555\x1ebrblack
  #   SETUVAR fish_color_cancel:\x2dr
  #   SETUVAR fish_color_command:blue
  #   SETUVAR fish_color_comment:red
  #   SETUVAR fish_color_cwd:green
  #   SETUVAR fish_color_cwd_root:red
  #   SETUVAR fish_color_end:green
  #   SETUVAR fish_color_error:brred
  #   SETUVAR fish_color_escape:brcyan
  #   SETUVAR fish_color_history_current:\x2d\x2dbold
  #   SETUVAR fish_color_host:normal
  #   SETUVAR fish_color_host_remote:yellow
  #   SETUVAR fish_color_normal:normal
  #   SETUVAR fish_color_operator:brcyan
  #   SETUVAR fish_color_param:cyan
  #   SETUVAR fish_color_quote:yellow
  #   SETUVAR fish_color_redirection:cyan\x1e\x2d\x2dbold
  #   SETUVAR fish_color_search_match:bryellow\x1e\x2d\x2dbackground\x3dbrblack
  #   SETUVAR fish_color_selection:white\x1e\x2d\x2dbold\x1e\x2d\x2dbackground\x3dbrblack
  #   SETUVAR fish_color_status:red
  #   SETUVAR fish_color_user:brgreen
  #   SETUVAR fish_color_valid_path:\x2d\x2dunderline
  #   SETUVAR fish_key_bindings:fish_default_key_bindings
  #   SETUVAR fish_pager_color_completion:normal
  #   SETUVAR fish_pager_color_description:B3A06D\x1eyellow\x1e\x2di
  #   SETUVAR fish_pager_color_prefix:normal\x1e\x2d\x2dbold\x1e\x2d\x2dunderline
  #   SETUVAR fish_pager_color_progress:brwhite\x1e\x2d\x2dbackground\x3dcyan
  #   SETUVAR fish_pager_color_selected_background:\x2dr
  #   SETUVAR sponge_allow_previously_successful:true
  #   SETUVAR sponge_delay:2
  #   SETUVAR sponge_filters:sponge_filter_failed\x1esponge_filter_matched
  #   SETUVAR sponge_purge_only_on_exit:false
  #   SETUVAR sponge_regex_patterns:\x1d
  #   SETUVAR sponge_successful_exit_codes:0
  #   SETUVAR tide_aws_bg_color:585858
  #   SETUVAR tide_aws_color:FF9900
  #   SETUVAR tide_aws_icon:\uf270
  #   SETUVAR tide_character_color:5FD700
  #   SETUVAR tide_character_color_failure:FF0000
  #   SETUVAR tide_character_icon:\u276f
  #   SETUVAR tide_character_vi_icon_default:\u276e
  #   SETUVAR tide_character_vi_icon_replace:\u25b6
  #   SETUVAR tide_character_vi_icon_visual:V
  #   SETUVAR tide_cmd_duration_bg_color:585858
  #   SETUVAR tide_cmd_duration_color:87875F
  #   SETUVAR tide_cmd_duration_decimals:0
  #   SETUVAR tide_cmd_duration_icon:\uf252
  #   SETUVAR tide_cmd_duration_threshold:3000
  #   SETUVAR tide_context_always_display:false
  #   SETUVAR tide_context_bg_color:585858
  #   SETUVAR tide_context_color_default:D7AF87
  #   SETUVAR tide_context_color_root:D7AF00
  #   SETUVAR tide_context_color_ssh:D7AF87
  #   SETUVAR tide_context_hostname_parts:1
  #   SETUVAR tide_crystal_bg_color:585858
  #   SETUVAR tide_crystal_color:FFFFFF
  #   SETUVAR tide_crystal_icon:\ue62f
  #   SETUVAR tide_direnv_bg_color:585858
  #   SETUVAR tide_direnv_bg_color_denied:585858
  #   SETUVAR tide_direnv_color:D7AF00
  #   SETUVAR tide_direnv_color_denied:FF0000
  #   SETUVAR tide_direnv_icon:\u25bc
  #   SETUVAR tide_distrobox_bg_color:585858
  #   SETUVAR tide_distrobox_color:FF00FF
  #   SETUVAR tide_distrobox_icon:\U000f01a7
  #   SETUVAR tide_docker_bg_color:585858
  #   SETUVAR tide_docker_color:2496ED
  #   SETUVAR tide_docker_default_contexts:default\x1ecolima
  #   SETUVAR tide_docker_icon:\uf308
  #   SETUVAR tide_elixir_bg_color:585858
  #   SETUVAR tide_elixir_color:4E2A8E
  #   SETUVAR tide_elixir_icon:\ue62d
  #   SETUVAR tide_gcloud_bg_color:585858
  #   SETUVAR tide_gcloud_color:4285F4
  #   SETUVAR tide_gcloud_icon:\U000f02ad
  #   SETUVAR tide_git_bg_color:585858
  #   SETUVAR tide_git_bg_color_unstable:585858
  #   SETUVAR tide_git_bg_color_urgent:585858
  #   SETUVAR tide_git_color_branch:5FD700
  #   SETUVAR tide_git_color_conflicted:FF0000
  #   SETUVAR tide_git_color_dirty:D7AF00
  #   SETUVAR tide_git_color_operation:FF0000
  #   SETUVAR tide_git_color_staged:D7AF00
  #   SETUVAR tide_git_color_stash:5FD700
  #   SETUVAR tide_git_color_untracked:00AFFF
  #   SETUVAR tide_git_color_upstream:5FD700
  #   SETUVAR tide_git_icon:\uf1d3
  #   SETUVAR tide_git_truncation_length:24
  #   SETUVAR tide_git_truncation_strategy:\x1d
  #   SETUVAR tide_go_bg_color:585858
  #   SETUVAR tide_go_color:00ACD7
  #   SETUVAR tide_go_icon:\ue627
  #   SETUVAR tide_java_bg_color:585858
  #   SETUVAR tide_java_color:ED8B00
  #   SETUVAR tide_java_icon:\ue256
  #   SETUVAR tide_jobs_bg_color:585858
  #   SETUVAR tide_jobs_color:5FAF00
  #   SETUVAR tide_jobs_icon:\uf013
  #   SETUVAR tide_kubectl_bg_color:585858
  #   SETUVAR tide_kubectl_color:326CE5
  #   SETUVAR tide_kubectl_icon:\U000f10fe
  #   SETUVAR tide_left_prompt_frame_enabled:true
  #   SETUVAR tide_left_prompt_items:os\x1epwd\x1egit\x1enewline\x1echaracter
  #   SETUVAR tide_left_prompt_prefix:
  #   SETUVAR tide_left_prompt_separator_diff_color:\ue0b0
  #   SETUVAR tide_left_prompt_separator_same_color:\ue0b1
  #   SETUVAR tide_left_prompt_suffix:\ue0b0
  #   SETUVAR tide_nix_shell_bg_color:585858
  #   SETUVAR tide_nix_shell_color:7EBAE4
  #   SETUVAR tide_nix_shell_icon:\uf313
  #   SETUVAR tide_node_bg_color:585858
  #   SETUVAR tide_node_color:44883E
  #   SETUVAR tide_node_icon:\ue24f
  #   SETUVAR tide_os_bg_color:585858
  #   SETUVAR tide_os_color:EEEEEE
  #   SETUVAR tide_os_icon:\uf313
  #   SETUVAR tide_php_bg_color:585858
  #   SETUVAR tide_php_color:617CBE
  #   SETUVAR tide_php_icon:\ue608
  #   SETUVAR tide_private_mode_bg_color:585858
  #   SETUVAR tide_private_mode_color:FFFFFF
  #   SETUVAR tide_private_mode_icon:\U000f05f9
  #   SETUVAR tide_prompt_add_newline_before:true
  #   SETUVAR tide_prompt_color_frame_and_connection:6C6C6C
  #   SETUVAR tide_prompt_color_separator_same_color:949494
  #   SETUVAR tide_prompt_icon_connection:\u00b7
  #   SETUVAR tide_prompt_min_cols:34
  #   SETUVAR tide_prompt_pad_items:true
  #   SETUVAR tide_prompt_transient_enabled:true
  #   SETUVAR tide_pulumi_bg_color:585858
  #   SETUVAR tide_pulumi_color:F7BF2A
  #   SETUVAR tide_pulumi_icon:\uf1b2
  #   SETUVAR tide_pwd_bg_color:585858
  #   SETUVAR tide_pwd_color_anchors:00AFFF
  #   SETUVAR tide_pwd_color_dirs:0087AF
  #   SETUVAR tide_pwd_color_truncated_dirs:8787AF
  #   SETUVAR tide_pwd_icon:\uf07c
  #   SETUVAR tide_pwd_icon_home:\uf015
  #   SETUVAR tide_pwd_icon_unwritable:\uf023
  #   SETUVAR tide_pwd_markers:\x2ebzr\x1e\x2ecitc\x1e\x2egit\x1e\x2ehg\x1e\x2enode\x2dversion\x1e\x2epython\x2dversion\x1e\x2eruby\x2dversion\x1e\x2eshorten_folder_marker\x1e\x2esvn\x1e\x2eterraform\x1eCargo\x2etoml\x1ecomposer\x2ejson\x1eCVS\x1ego\x2emod\x1epackage\x2ejson
  #   SETUVAR tide_python_bg_color:585858
  #   SETUVAR tide_python_color:00AFAF
  #   SETUVAR tide_python_icon:\U000f0320
  #   SETUVAR tide_right_prompt_frame_enabled:false
  #   SETUVAR tide_right_prompt_items:status\x1ecmd_duration\x1econtext\x1ejobs\x1edirenv\x1enode\x1epython\x1erustc\x1ejava\x1ephp\x1epulumi\x1eruby\x1ego\x1egcloud\x1ekubectl\x1edistrobox\x1etoolbox\x1eterraform\x1eaws\x1enix_shell\x1ecrystal\x1eelixir\x1etime
  #   SETUVAR tide_right_prompt_prefix:\ue0b2
  #   SETUVAR tide_right_prompt_separator_diff_color:\ue0b2
  #   SETUVAR tide_right_prompt_separator_same_color:\ue0b3
  #   SETUVAR tide_right_prompt_suffix:
  #   SETUVAR tide_ruby_bg_color:585858
  #   SETUVAR tide_ruby_color:B31209
  #   SETUVAR tide_ruby_icon:\ue23e
  #   SETUVAR tide_rustc_bg_color:585858
  #   SETUVAR tide_rustc_color:F74C00
  #   SETUVAR tide_rustc_icon:\ue7a8
  #   SETUVAR tide_shlvl_bg_color:585858
  #   SETUVAR tide_shlvl_color:d78700
  #   SETUVAR tide_shlvl_icon:\uf120
  #   SETUVAR tide_shlvl_threshold:1
  #   SETUVAR tide_status_bg_color:585858
  #   SETUVAR tide_status_bg_color_failure:585858
  #   SETUVAR tide_status_color:5FAF00
  #   SETUVAR tide_status_color_failure:D70000
  #   SETUVAR tide_status_icon:\u2714
  #   SETUVAR tide_status_icon_failure:\u2718
  #   SETUVAR tide_terraform_bg_color:585858
  #   SETUVAR tide_terraform_color:844FBA
  #   SETUVAR tide_terraform_icon:\x1d
  #   SETUVAR tide_time_bg_color:585858
  #   SETUVAR tide_time_color:5F8787
  #   SETUVAR tide_time_format:\x25T
  #   SETUVAR tide_toolbox_bg_color:585858
  #   SETUVAR tide_toolbox_color:613583
  #   SETUVAR tide_toolbox_icon:\ue24f
  #   SETUVAR tide_vi_mode_bg_color_default:585858
  #   SETUVAR tide_vi_mode_bg_color_insert:585858
  #   SETUVAR tide_vi_mode_bg_color_replace:585858
  #   SETUVAR tide_vi_mode_bg_color_visual:585858
  #   SETUVAR tide_vi_mode_color_default:949494
  #   SETUVAR tide_vi_mode_color_insert:87AFAF
  #   SETUVAR tide_vi_mode_color_replace:87AF87
  #   SETUVAR tide_vi_mode_color_visual:FF8700
  #   SETUVAR tide_vi_mode_icon_default:D
  #   SETUVAR tide_vi_mode_icon_insert:I
  #   SETUVAR tide_vi_mode_icon_replace:R
  #   SETUVAR tide_vi_mode_icon_visual:V
  # '';

}
