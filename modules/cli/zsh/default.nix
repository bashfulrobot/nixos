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
    system.userActivationScripts.zshrc = "touch .zshrc";

    home-manager.users."${user-settings.user.username}" = {

      programs = {
        zsh = {
          enable = true;
          enableCompletion = true;
          autosuggestion.enable = true;
          syntaxHighlighting.enable = true;
          autocd = true;

          shellAliases = {
            ll = "ls -l";
            edit = "sudo -e";
            update = "sudo nixos-rebuild switch";
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
              { name = "ptavares/zsh-direnv"; }
              {
                name = "romkatv/powerlevel10k";
                tags = [ "as:theme" "depth:1" ];
              } # Installations with additional options. For the list of options, please refer to Zplug README.
            ];
          };
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
