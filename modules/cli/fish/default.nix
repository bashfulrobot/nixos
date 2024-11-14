{ user-settings, lib, pkgs, secrets, config, ... }:
let
  cfg = config.cli.fish;
  fd-flags = lib.concatStringsSep " " [ "--hidden" "--exclude '.git'" ];

in
{

  options = {
    cli.fish.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the fish shell.";
    };
  };

  config = lib.mkIf cfg.enable {
    # You can enable the fish shell and manage fish configuration and plugins with Home Manager, but to enable vendor fish completions provided by Nixpkgs you will also want to enable the fish shell in /etc/nixos/configuration.nix:
    programs.fish.enable = true;

    home-manager.users."${user-settings.user.username}" = {
      programs.fish = {
        enable = true;
        shellInit = ''
          # Shell Init
          direnv hook fish | source
          source ${user-settings.user.home}/.config/op/plugins.sh
        '';
        interactiveShellInit = ''
          set fish_greeting # Disable greeting
          source ${user-settings.user.home}/.config/op/plugins.sh
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
          # get_window_class = ''
          #   , hyprctl clients | grep 'class:' | awk '{print $2}' | fzf | wl-copy --trim-newline
          # '';
          # get_window_title = ''
          #   , hyprctl clients | grep 'class:' | awk '{print $2}' | fzf | wl-copy --trim-newline
          # '';
          active_nixstore_pkg = ''
            set -l query $argv
            if test -z "$query"
                echo "Usage: nix-find <search-term>"
                return 1
            end

            nix-store --query --requisites /run/current-system | grep --ignore-case $query
            #exa -R (nix-store --query --requisites /run/current-system | grep --ignore-case $query)
          '';

          active_nixstore_file = ''
            set search_term $argv[1]
            sudo fd -Hi $search_term (readlink -f /run/current-system/sw)
          '';
          # Not working for OP yet.
          # op_signin = ''
          #   op list templates >> /dev/null 2>&1
          #   	if test $status -ne 0
          #   		eval (op signin)
          #   	end
          # '';

          # op_get_names = ''
          #   op item list | jq -r '.[].overview.title'
          # '';

          # op_get_entry = ''
          #     set json (op item get "$argv[1]")
          #   	set username (echo $json | jq -r '.details.fields[]|select(.designation=="username")|.value')
          #   	set password (echo $json | jq -r '.details.fields[]|select(.designation=="password")|.value')
          #   	echo "item: $argv[1] | user: $username | pass: $password"
          # '';

          # oppw = ''
          #   op_signin
          #   	set opname (op_get_names | fzf)
          #   	op_get_entry $opname
          # '';

          # GNOME Shell Version
          # get_wm_class = ''
          #   gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell/Extensions/Windows --method org.gnome.Shell.Extensions.Windows.List | grep -Po '"wm_class_instance":"\K[^"]*'
          #   gtk-update-icon-cache
          # '';

          # X11 / Budgie Version
          get_wm_class = ''
            xprop | grep WM_CLASS | awk -F '"' '{print $2}' | xclip -selection clipboard
          '';

          scratch-new = ''
           set date (date "+%Y-%m-%d")
set note_type (echo -e "External Meeting\nReminder\nInternal Meeting\nProduct Note" | fzf --prompt="Select note type: ")
cd ~/Documents/Scratch/
switch $note_type
    case "External Meeting"
        set folder ExternalMeeting
    case Reminder
        set folder Reminder
    case "Internal Meeting"
        set folder InternalMeeting
    case "Product Note"
        set folder ProductNote
end

read -P "Enter file name: " filename_suffix
set filename "$folder/$date-$filename_suffix.md"

# Create the folder if it doesn't exist
mkdir -p $folder

touch $filename
echo "# "$date" "$filename_suffix | tr - ' ' >$filename

switch $note_type
    case "External Meeting"
        echo "# "$date" "$filename_suffix | tr '-' ' ' > $filename
        echo >>$filename
        echo "## Meeting Type" >>$filename
        echo >>$filename
        echo "- External Meeting" >>$filename
        echo >>$filename
        echo "## Attendees" >>$filename
        echo >>$filename
        echo "## Summary" >>$filename
        echo >>$filename
        echo "## Action Items" >>$filename
        echo >>$filename
    case "Internal Meeting"
        echo "# "$date" "$filename_suffix | tr '-' ' ' > $filename
        echo >>$filename
        echo "## Meeting Type" >>$filename
        echo >>$filename
        echo "- Internal Meeting" >>$filename
        echo >>$filename
        echo "## Attendees" >>$filename
        echo >>$filename
        echo "## Summary" >>$filename
        echo >>$filename
        echo "## Action Items" >>$filename
        echo >>$filename
    case "Product Note"
        set product_name (echo -e "Secure\nMonitor\nPlatform" | fzf --prompt="Select product name: ")
        set use_cases (echo -e "CDR\nTD\nVM\nCSPM\nCIEM" | fzf --prompt="Select use cases: " --multi --delimiter="\n")
        echo "# "$date" "$filename_suffix | tr '-' ' ' > $filename
        echo >>$filename
        echo "## $product_name" >>$filename
        echo >>$filename
        for use_case in $use_cases
            echo "## $use_case" >>$filename
            echo >>$filename
        end
        echo "## Notes" >>$filename
        echo >>$filename
        echo "## Action Items" >>$filename
        echo >>$filename
end

nvim $filename

          '';

          scratch = ''
            cd ~/Documents/Scratch/
            glow
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
          k_stuck_terminating = ''
                if test -z $argv[1]
                    echo "Please provide a namespace."
                    return 1
                end

                kubectl api-resources --verbs=list --namespaced -o name | xargs -n 1 kubectl get --show-kind --ignore-not-found -n $argv[1]
            end '';
          k_force_terminating_ns = ''
            set NS (kubectl get ns | grep Terminating | awk 'NR==1 {print $1}')
            kubectl get namespace $NS -o json | tr -d "\n" | sed "s/\"finalizers\": \[[^]]\+\]/\"finalizers\": []/" | kubectl replace --raw /api/v1/namespaces/$NS/finalize -f -
          '';

          get_containers_in_pods = ''
            if test -z $argv[1]
                echo "Please provide a namespace."
                return 1
            end

            set namespace $argv[1]

            kubectl get pods -n $namespace -o jsonpath='{range .items[*]}{"\n"}{.metadata.name}{":\t"}{range .spec.containers[*]}{.name}{", "}{end}{end}' && echo
          '';

          get_libvirt_networks = ''
                for net in (sudo virsh net-list --all | awk 'NR>2 {print $1}')
                if test -n "$net"
                    echo "Network: $net"
                    sudo virsh net-info $net | grep 'Bridge:'
                end
            end
          '';
        };
        shellAbbrs = {
          nix-lint =
            "fd -e nix --hidden --no-ignore --follow . -x statix check {}";
          k = "kubectl";
          t = "talosctl";
          kcx = "kubectx";
          kns = "kubens";
          tf = "terraform";
          tfa = "terraform apply";
          tfd = "terraform destroy";
          tfi = "terraform init -upgrade";
          tfp = "terraform plan";
          tfs = "terraform state list";
          dc = "docker compose";
          gc = "git pull && git add . && git commit -S && git push";
        };
        shellAliases = {
          support-info =
            ", fastfetch --logo none -c ${user-settings.user.home}/dev/nix/nixos/modules/cli/fastfetch/support.jsonc | xclip -selection clipboard";
          support-info-extended =
            ", fastfetch --logo none -c ${user-settings.user.home}/dev/nix/nixos/modules/cli/fastfetch/support-extended.jsonc | xclip -selection clipboard";
          tshoot-last-boot = "sudo journalctl -b -1 | curl -F 'file=@-' 0x0.st";
          copy-icons = "copy_icons";
          echo-home = "echo ${user-settings.user.home}";
          hm-logs =
            "sudo systemctl restart home-manager-dustin.service; journalctl -xeu home-manager-dustin.service";
          tailscale-up-lt =
            "sudo tailscale up --ssh --accept-routes --operator=$USER";
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
          ips = "ip -o -4 addr list | awk '{print $2, $4}'";
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
          do-update =
            "gon && git pull && just upgrade-system && git add -A && git commit -S && git push";
          goagent = "cd ~/dev/sysdig/sysdig-agent-deploy/";
          goscreen = "cd ~/Pictures/Screenshots/";
          y = "cd ~/; yazi";
          e = "nvim";
          vi = "nvim";
          vim = "nvim";
          ny = "cd ~/dev/nix/nixos/; yazi";
          n = "cd ~/dev/nix/nixos/; nvim";
          nc =
            "clear && cd ~/dev/nix/nixos && git add . && git commit -S && rm -f ${user-settings.user.home}/.config/mimeapps.list && rebuild && cd ~/dev/nix/nixos && git push";
          ls = "${pkgs.eza}/bin/eza -al --octal-permissions --icons";
          # ls = "${pkgs.eza}/bin/eza -al --octal-permissions";
          font-cache-refresh = "sudo fc-cache -f -v";
          font-list = "fc-list";
          grep = "${pkgs.ripgrep}/bin/rg";
          du = "${pkgs.du-dust}/bin/dust";
          ps = "${pkgs.procs}/bin/procs";
          man = "${pkgs.tealdeer}/bin/tldr";
          top = "${pkgs.btop}/bin/btop";
          htop = "${pkgs.btop}/bin/btop";
          #sed = "${pkgs.sd}/bin/sd";
          ping = "${pkgs.gping}/bin/gping";
          # just = "${pkgs.just}/bin/just --choose --unsorted";
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
            "clear && echo;echo '***** UPDATE APPIMAGES PERIODIALLY *****'; echo;  sleep 1; cd ~/dev/nix/nixos/ && ${pkgs.just}/bin/just rebuild";
          upgrade =
            "clear && cd ~/dev/nix/nixos/; ${pkgs.just}/bin/just upgrade-system";
          dev-rebuild =
            "clear && cd ~/dev/nix/nixos/; rm -f ${user-settings.user.home}/.config/mimeapps.list && ${pkgs.just}/bin/just dev-rebuild";
          test-rebuild =
            "clear && cd ~/dev/nix/nixos/; rm -f ${user-settings.user.home}/.config/mimeapps.list && ${pkgs.just}/bin/just dev-test";
          kubitect =
            "${pkgs.steam-run}/bin/steam-run /etc/profiles/per-user/dustin/bin/kubitect";
          # comics-downloader = "${pkgs.steam-run}/bin/steam-run /etc/profiles/per-user/dustin/bin/comics-downloader";
          comma-db =
            "nix run 'nixpkgs#nix-index' --extra-experimental-features 'nix-command flakes'";
        };

      };

      programs = {
        fzf = {
          enable = true;
          enableFishIntegration = true;
          defaultCommand = "fd --type f ${fd-flags}";
          fileWidgetCommand = "fd --type f ${fd-flags}";
          changeDirWidgetCommand = "fd --type d ${fd-flags}";
        };
        atuin = {
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
        yazi.enableFishIntegration = true;
        nix-index.enableFishIntegration = true;
        eza.enableFishIntegration = true;
        autojump.enableFishIntegration = true;
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
  };
}
