{ lib, pkgs, secrets, ... }:
let
  fd-flags = lib.concatStringsSep " " [ "--hidden" "--exclude '.git'" ];
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {
  home-manager.users."${username}" = {
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
      new-scratch = ''
        set date (date "+%Y-%m-%d")
        set filename "$date-$argv[1].md"
        touch $filename
        echo "# "$date" "$argv[1] | tr '-' ' ' > $filename
        echo >> $filename
        echo "## Attendees" >> $filename
        echo >> $filename
        echo "## Summary" >> $filename
        echo >> $filename
        echo "## Action Items" >> $filename
        echo >> $filename
        lvim $filename
      '';
      run_nix_package = ''
        set -x NIXPKGS_ALLOW_UNFREE 1
        nix run nixpkgs#$argv[1] --impure
      '';
      search_nixpkgs = ''
        nix-env -qaP | grep -i $pattern
      '';
      shutdown_all_local_vms = ''
        set -l domains (sudo virsh list --name --state-running)
        if test -z "$domains"
          echo "No running VMs detected." | gum format -t template | gum format -t emoji
        else
          echo "Shutting down the following VMs:" | gum format -t template | gum format -t emoji
          for domain in $domains
            echo "Shutting down $domain..." | gum format -t template | gum format -t emoji
            sudo virsh shutdown $domain
            if test $status -eq 0
              echo "$domain has been shut down successfully." | gum format -t template | gum format -t emoji
            else
              echo "Failed to shut down $domain." | gum format -t template | gum format -t emoji
            end
          end
        end
      '';
      download_kubeconfig = ''
        if test (count $argv) -ne 2
            echo "Error: This function requires two arguments: the remote server IP and the Kubernetes cluster name."
            return 1
        end

        set ip $argv[1]
        set kubeconfig_name $argv[2]
        set url http://$ip:8080/kubeconfig

        while not curl --output /dev/null --silent --head --fail $url
          echo "Waiting for kubeconfig file to exist..."
          sleep 5
        end

        cd ~/.kube/clusters/
        wget $url
        mv $kubeconfig_name-kubeconfig $kubeconfig_name-kubeconfig-old
        mv kubeconfig $kubeconfig_name-kubeconfig
        code $kubeconfig_name-kubeconfig
      '';
      libvirt_list_all_networks = ''
        if test (count $argv) -eq 1
          set filter $argv[1]
          sudo virsh net-list --all | grep $filter
        else if test (count $argv) -eq 0
          sudo virsh net-list --all
        else
          echo "Error: This function requires zero or one argument: an optional filter."
          return 1
        end
      '';

      libvirt_list_all_pools = ''
        if test (count $argv) -eq 1
          set filter $argv[1]
          sudo virsh pool-list --all | grep $filter
        else if test (count $argv) -eq 0
          sudo virsh pool-list --all
        else
          echo "Error: This function requires zero or one argument: an optional filter."
          return 1
        end
      '';

      libvirt_list_all_images = ''
        if test (count $argv) -eq 1
          set filter $argv[1]
          sudo virsh vol-list --pool $filter
        else if test (count $argv) -eq 0
          sudo virsh vol-list --pool default
        else
          echo "Error: This function requires zero or one argument: an optional volume name filter."
          return 1
        end
      '';

      libvirt_list_all_vms = ''
        if test (count $argv) -eq 1
          set filter $argv[1]
          sudo virsh list --all | grep $filter
        else if test (count $argv) -eq 0
          sudo virsh list --all
        else
          echo "Error: This function requires zero or one argument: an optional filter."
          return 1
        end
      '';
      send_to_phone = ''
        if test (count $argv) -ne 1
            echo "Error: This function requires a file path as an argument."
            return 1
        end

        set file_path $argv[1]
        tailscale file cp $file_path maximus:
      '';
      delete_all_in_namespace = ''
        if test (count $argv) -ne 1
            echo "Error: This function requires a namespace as an argument."
            return 1
        end

        set namespace $argv[1]
        kubectl --namespace $namespace delete (kubectl api-resources --namespaced=true --verbs=delete -o name | tr "\n" "," | sed -e 's/,$//') --all
      '';
    };
    shellAbbrs = {
      k = "kubectl";
      kcx = "kubectx";
      kns = "kubens";
      tf = "terraform";
      tfa = "terraform apply";
      tfd = "terraform destroy";
      tfi = "terraform init -upgrade";
      tfp = "terraform plan";
      tfs = "terraform state list";
      dc = "docker compose";
      gc = "git add . && git commit -S && git push && git pull";
    };
    shellAliases = {
      oc = "~/.npm-packages/bin/opencommit";
      ncdu = "${pkgs.gdu}/bin/gdu";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      sysdig-cli-scanner-recent-version =
        "curl -L -s https://download.sysdig.com/scanning/sysdig-cli-scanner/latest_version.txt";
      sysdig-cli-scanner-get = ''
        curl -LO "https://download.sysdig.com/scanning/bin/sysdig-cli-scanner/$(curl -L -s https://download.sysdig.com/scanning/sysdig-cli-scanner/latest_version.txt)/linux/amd64/sysdig-cli-scanner"'';
      kubectl = "${pkgs.kubecolor}/bin/kubecolor";
      ipull = "instruqt track pull";
      ipush = "instruqt track push";
      ilog = "instruqt track logs";
      gosysdig = "cd ~/dev/sysdig/";
      gotf = "cd ~/dev/terraform";
      gotfc = "cd ~/dev/terraform/clusters/";
      gotfm = "cd ~/dev/terraform/modules/";
      gotf-e = "cd ~/dev/terraform && code -r .";
      gos = "cd ~/Documents/Scratch/";
      gon = "cd ~/dev/nix/nixos";
      gon-e = "cd ~/dev/nix/nixos && code -r .";
      goagent = "cd ~/dev/sysdig/sysdig-agent-deploy/";
      goscreen = "cd ~/Pictures/Screenshots/";
      y = "cd ~/; yazi";
      e = "lvim";
      nvim = "lvim";
      vi = "lvim";
      vim = "lvim";
      ny = "cd ~/dev/nix/nixos/; yazi";
      n = "cd ~/dev/nix/nixos/; lvim";
      nc =
        "clear && cd ~/dev/nix/nixos && git add . && git commit -S && rm -f /home/dustin/.config/mimeapps.list && rebuild && cd ~/dev/nix/nixos && git push";
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
      ping = "${pkgs.gping}/bin/gping";
      just = "${pkgs.just}/bin/just --choose";
      nixcfg = "${pkgs.man}/bin/man configuration.nix";
      hmcfg = "${pkgs.man}/bin/man home-configuration.nix";
      rustscan =
        "${pkgs.docker}/bin/docker run -it --rm --name rustscan rustscan/rustscan:latest";
      kcfg =
        "sudo chown -R dustin ~/.kube && sudo chmod -R 0700 ~/.kube && cd ~/.kube && ${pkgs.just}/bin/just";
      vms = "sudo ${pkgs.libvirt}/bin/virsh list --all";
      yless = "${pkgs.jless}/bin/jless --yaml";
      # please = "${pkgs.shell-genie}/bin/shell-genie ask";
      rebuild =
        "clear && echo;echo '***** UPDATE APPIMAGES PERIODIALLY *****'; echo;  sleep 1; cd ~/dev/nix/nixos/; rm -f /home/dustin/.config/mimeapps.list && ${pkgs.just}/bin/just rebuild; cd -";
      upgrade =
        "clear && cd ~/dev/nix/nixos/; ${pkgs.just}/bin/just upgrade-system";
      dev-rebuild =
        "clear && cd ~/dev/nix/nixos/; rm -f /home/dustin/.config/mimeapps.list && ${pkgs.just}/bin/just dev-rebuild";
      kubitect =
        "${pkgs.steam-run}/bin/steam-run /etc/profiles/per-user/dustin/bin/kubitect";
      # comics-downloader = "${pkgs.steam-run}/bin/steam-run /etc/profiles/per-user/dustin/bin/comics-downloader";
      comma-db =
        "nix run 'nixpkgs#nix-index' --extra-experimental-features 'nix-command flakes'";
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
    enable = true;
    enableFishIntegration = true;
    flags = [ "--disable-up-arrow" ];
    settings = {
      auto_sync = true;
      sync_frequency = "5m";
      sync_address = "https://api.atuin.sh";
      search_mode = "fuzzy";
      filter_mode_shell_up_key_binding = "directory";
      style = "compact";

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
    gum
  ];

  # home.file."fish_variables" = {
  #   source = ./fish_variables;
  #   target = ".config/fish/fish_variables";
  # };

  };

}
