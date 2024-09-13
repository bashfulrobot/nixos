# https://github.com/alexhulbert/SeaGlass/blob/47596c6cae0866c70ed4ed9b978fa227c4fb8b8c/user/terminal.nix#L124
{ user-settings, pkgs, secrets, config, lib, ... }:
let cfg = config.cli.zsh;
in {
  options = {
    cli.zsh.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable zsh shell.";
    };
  };

  config = lib.mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [  ];
    # Prevent the new user dialog in zsh
    # system.userActivationScripts.zshrc = "touch .zshrc";

    environment.shells = with pkgs; [ zsh ];
    programs.zsh.enable = true;

    home-manager.users."${user-settings.user.username}" = {

      programs = {
        zsh = {
          enable = true;
          enableCompletion = true;
          autosuggestion.enable = true;
          syntaxHighlighting.enable = true;
          autocd = true;

          shellAliases = {

            support-info =
              ", fastfetch --logo none -c ${user-settings.user.home}/dev/nix/nixos/modules/cli/fastfetch/support.jsonc | xclip -selection clipboard";
            support-info-extended =
              ", fastfetch --logo none -c ${user-settings.user.home}/dev/nix/nixos/modules/cli/fastfetch/support-extended.jsonc | xclip -selection clipboard";
            tshoot-last-boot =
              "sudo journalctl -b -1 | curl -F 'file=@-' 0x0.st";
            copy-icons = "copy_icons";
            hm-logs =
              "sudo systemctl restart home-manager-dustin.service; journalctl -xeu home-manager-dustin.service";
            tailscale-up-lt =
              "sudo tailscale up --ssh --accept-routes --operator=$USER";
            oc = "~/.npm-packages/bin/opencommit";
            ncdu = "${pkgs.gdu}/bin/gdu";
            ips = "ip -o -4 addr list | awk '{print $2, $4}'";
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
            cat = "${pkgs.bat}/bin/bat";
            grep = "${pkgs.ripgrep}/bin/rg";
            du = "${pkgs.du-dust}/bin/dust";
            ps = "${pkgs.procs}/bin/procs";
            man = "${pkgs.tealdeer}/bin/tldr";
            top = "${pkgs.bottom}/bin/btm";
            htop = "${pkgs.bottom}/bin/btm";
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
            nix-lint =
              "fd -e nix --hidden --no-ignore --follow . -x statix check {}";
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

          history.size = 10000;
          history.ignoreAllDups = true;
          history.path = "$HOME/.zsh_history";
          history.ignorePatterns = [ "rm *" "pkill *" "cp *" ];

          zplug = {
            enable = true;
            plugins = [
              { name = "zsh-users/zsh-autosuggestions"; }
              { name = "chisui/zsh-nix-shell"; }
              { name = "zsh-users/zsh-syntax-highlighting"; }
              { name = "zsh-users/zsh-history-substring-search"; }
              {
                name = "ptavares/zsh-direnv";
              }
              # {
              # name = "romkatv/powerlevel10k";
              # tags = [ "as:theme" "depth:1" ];
              # } # Installations with additional options. For the list of options, please refer to Zplug README.
            ];
          };

          initExtra = ''

            # Function to search for a package in the Nix store based on a query
            active_nixstore_pkg() {
              query=$1
              if [ -z "$query" ]; then
                echo "Usage: nix-find <search-term>"
                return 1
              fi
              nix-store --query --requisites /run/current-system | grep --ignore-case "$query"
            }

            # Function to search for a file in the Nix store based on a search term
            active_nixstore_file() {
              search_term=$1
              sudo fd -Hi "$search_term" "$(readlink -f /run/current-system/sw)"
            }

            # Function to get the window manager class of GNOME Shell extensions
            get_wm_class() {
              gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell/Extensions/Windows --method org.gnome.Shell.Extensions.Windows.List | grep -Po '"wm_class_instance":"\K[^"]*'
              gtk-update-icon-cache
            }

            # Function to run a Nix package with unfree packages allowed
            run_nix_package() {
              export NIXPKGS_ALLOW_UNFREE=1
              nix run "nixpkgs#$1" --impure
            }

            # Function to search for Nix packages based on a query
            search_nixpkgs() {
              nix-env -qaP | grep -i "$1"
            }

            # Function to shut down all running local virtual machines
            shutdown_all_local_vms() {
              domains=$(sudo virsh list --name --state-running)
              if [ -z "$domains" ]; then
                echo "No running VMs detected." | gum format -t template | gum format -t emoji
              else
                echo "Shutting down the following VMs:" | gum format -t template | gum format -t emoji
                for domain in $domains; do
                  echo "Shutting down $domain..." | gum format -t template | gum format -t emoji
                  sudo virsh shutdown $domain
                  if [ $? -eq 0 ]; then
                    echo "$domain has been shut down successfully." | gum format -t template | gum format -t emoji
                  else
                    echo "Failed to shut down $domain." | gum format -t template | gum format -t emoji
                  fi
                done
              fi
            }

            # Function to download a Kubernetes kubeconfig file from a remote server
            download_kubeconfig() {
              if [ $# -ne 2 ]; then
                echo "Error: This function requires two arguments: the remote server IP and the Kubernetes cluster name."
                return 1
              fi
              ip=$1
              kubeconfig_name=$2
              url="http://$ip:8080/kubeconfig"
              while ! curl --output /dev/null --silent --head --fail "$url"; do
                echo "Waiting for kubeconfig file to exist..."
                sleep 5
              done
              cd ~/.kube/clusters/
              wget "$url"
              mv "$kubeconfig_name-kubeconfig" "$kubeconfig_name-kubeconfig-old"
              mv kubeconfig "$kubeconfig_name-kubeconfig"
              code "$kubeconfig_name-kubeconfig"
            }

            # Function to list all libvirt networks, optionally filtered by a search term
            libvirt_list_all_networks() {
              if [ $# -eq 1 ]; then
                filter=$1
                sudo virsh net-list --all | grep "$filter"
              elif [ $# -eq 0 ]; then
                sudo virsh net-list --all
              else
                echo "Error: This function requires zero or one argument: an optional filter."
                return 1
              fi
            }

            # Function to list all libvirt storage pools, optionally filtered by a search term
            libvirt_list_all_pools() {
              if [ $# -eq 1 ]; then
                filter=$1
                sudo virsh pool-list --all | grep "$filter"
              elif [ $# -eq 0 ]; then
                sudo virsh pool-list --all
              else
                echo "Error: This function requires zero or one argument: an optional filter."
                return 1
              fi
            }

            # Function to list all libvirt storage volumes, optionally filtered by a search term
            libvirt_list_all_images() {
              if [ $# -eq 1]; then
                filter=$1
                sudo virsh vol-list --pool "$filter"
              elif [ $# -eq 0 ]; then
                sudo virsh vol-list --pool default
              else
                echo "Error: This function requires zero or one argument: an optional volume name filter."
                return 1
              fi
            }

            # Function to list all libvirt virtual machines, optionally filtered by a search term
            libvirt_list_all_vms() {
              if [ $# -eq 1 ]; then
                filter=$1
                sudo virsh list --all | grep "$filter"
              elif [ $# -eq 0 ]; then
                sudo virsh list --all
              else
                echo "Error: This function requires zero or one argument: an optional filter."
                return 1
              fi
            }

            # Function to send a file to a phone using Tailscale
            send_to_phone() {
              if [ $# -ne 1 ]; then
                echo "Error: This function requires a file path as an argument."
                return 1
              fi
              file_path=$1
              tailscale file cp "$file_path" maximus:
            }

            # Function to delete all resources in a Kubernetes namespace
            delete_all_in_namespace() {
              if [ $# -ne 1 ]; then
                echo "Error: This function requires a namespace as an argument."
                return 1
              fi
              namespace=$1
              kubectl --namespace "$namespace" delete $(kubectl api-resources --namespaced=true --verbs=delete -o name | tr "\n" "," | sed -e 's/,$//') --all
            }

            # Function to list all stuck terminating resources in a Kubernetes namespace
            k_stuck_terminating() {
              if [ -z "$1" ]; then
                echo "Please provide a namespace."
                return 1
              fi
              kubectl api-resources --verbs=list --namespaced -o name | xargs -n 1 kubectl get --show-kind --ignore-not-found -n "$1"
            }

            # Function to forcefully terminate a stuck Kubernetes namespace
            k_force_terminating_ns() {
              NS=$(kubectl get ns | grep Terminating | awk 'NR==1 {print $1}')
              kubectl get namespace "$NS" -o json | tr -d "\n" | sed 's/"finalizers": \[[^]]\+\]/"finalizers": []/' | kubectl replace --raw "/api/v1/namespaces/$NS/finalize" -f -
            }

            # Function to get the containers in all pods within a Kubernetes namespace
            get_containers_in_pods() {
              if [ -z "$1" ]; then
                echo "Please provide a namespace."
                return 1
              fi
              namespace=$1
              kubectl get pods -n "$namespace" -o jsonpath='{range .items[*]}{"\n"}{.metadata.name}{":\t"}{range .spec.containers[*]}{.name}{", "}{end}{end}' && echo
            }

            # Function to get information about all libvirt networks
            get_libvirt_networks() {
              for net in $(sudo virsh net-list --all | awk 'NR>2 {print $1}'); do
                if [ -n "$net" ]; then
                  echo "Network: $net"
                  sudo virsh net-info "$net" | grep 'Bridge:'
                fi
              done
            }

          '';
        };

        starship = {
          enable = true;
          enableZshIntegration = true;
          settings = {
            character = {
              success_symbol = "[](bold)";
              error_symbol = "[](bold)";
            };
            format = "$custom$character";
            right_format = "$all";
            add_newline = false;
            line_break.disabled = true;
            package.disabled = true;
            container.disabled = true;
            git_status = {
              untracked = "";
              stashed = "";
              modified = "";
              staged = "";
              renamed = "";
              deleted = "";
            };
            terraform.symbol = " ";
            git_branch.symbol = " ";
            directory.read_only = " ";
            custom.env = {
              command = "cat /etc/prompt";
              format = "$output ";
              when = "test -f /etc/prompt";
            };
            rust = {
              format = "[$symbol]($style)";
              symbol = " ";
            };
            scala = {
              format = "[$symbol]($style)";
              symbol = " ";
            };
            nix_shell = {
              format = "[$symbol$name ]($style)";
              symbol = " ";
            };
            nodejs = {
              format = "[$symbol]($style)";
              symbol = " ";
            };
            golang = {
              format = "[$symbol]($style)";
              symbol = " ";
            };
            java = {
              format = "[$symbol]($style)";
              symbol = " ";
            };
            deno = {
              format = "[$symbol]($style)";
              symbol = " ";
            };
            lua = {
              format = "[$symbol]($style)";
              symbol = " ";
            };
            docker_context = {
              format = "[$symbol]($style)";
              symbol = " ";
            };
            python = {
              format = "[$symbol]($style)";
              symbol = " ";
            };
            gcloud.disabled = true;
            aws.disabled = true;
          };
        };

        fzf.enableZshIntegration = true;
        yazi.enableZshIntegration = true;
        nix-index.enableZshIntegration = true;
        eza.enableZshIntegration = true;
        direnv.enableZshIntegration = true;
        autojump.enableZshIntegration = true;

      };

    };
  };

}
