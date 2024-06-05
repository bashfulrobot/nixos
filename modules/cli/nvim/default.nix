{ pkgs, config, lib, ... }:
let
  cfg = config.cli.nvim;
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {

  options = {
    cli.nvim.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable nvim editor.";
    };
  };

  config = lib.mkIf cfg.enable {

    home-manager.users."${username}" = lib.trace "nvim HM module ran"  {
      home = {

        # packages = with pkgs;
        #   [
        #     jeezyvim # opinionated neovim
        #   ];

        sessionVariables = { EDITOR = "nvim"; };

        packages = [
          pkgs.vimPlugins.CopilotChat-nvim
          (pkgs.jeezyvim.nixvimExtend {
            # you can put anything under the "Options" section of the NixVim docs here
            # https://nix-community.github.io/nixvim/

            # some examples...

            # all your regular vim options here
            options = { textwidth = 120; };

            config = {
              keymaps = [

                # toggle comments on selected lines (visual mode)
                {
                  mode = "v";
                  action = "gc";
                  key = "<Space>.";
                }
                # toggle comments on current line (normal mode) (ctrl=/)
                {
                  mode = "n";
                  action = "gcc";
                  key = "<C-c>";
                }
                # save file with ctrl-s
                {
                  mode = "n";
                  action = ":w<CR>";
                  key = "<C-s>";
                }

                # {
                #   mode = "n";
                #   action = ":vsplit<CR>";
                #   key = "|";
                # }

                # {
                #   mode = "n";
                #   action = ":split<CR>";
                #   key = "-";
                # }

              ];
              plugins = {
                lsp.servers = {

                  # full list of language servers you can enable on the left bar here:
                  # https://nix-community.github.io/nixvim/plugins/lsp/servers/ansiblels/index.html
                  bashls.enable = pkgs.lib.mkForce true;
                  docker-compose-language-service.enable = true;
                  dockerls.enable = pkgs.lib.mkForce false;
                  gopls.enable = pkgs.lib.mkForce false;
                  graphql.enable = pkgs.lib.mkForce false;
                  helm-ls.enable = pkgs.lib.mkForce false;
                  html.enable = pkgs.lib.mkForce false;
                  htmx.enable = pkgs.lib.mkForce false;
                  jsonls.enable = pkgs.lib.mkForce false;
                  marksman.enable = pkgs.lib.mkForce false;
                  nginx-language-server.enable = pkgs.lib.mkForce false;
                  nixd.enable = pkgs.lib.mkForce false;
                  pylsp.enable = pkgs.lib.mkForce false;
                  rust-analyzer.enable = pkgs.lib.mkForce false;
                  svelte.enable = pkgs.lib.mkForce false;
                  tailwindcss.enable = pkgs.lib.mkForce false;
                  terraformls.enable = pkgs.lib.mkForce false;
                  yamlls.enable = pkgs.lib.mkForce false;

                };

                # full list of plugins on the left bar here:
                # https://nix-community.github.io/nixvim/plugins/airline/index.html

                # readme - for config: https://github.com/m4xshen/autoclose.nvim?tab=readme-ov-file#-configuration
                autoclose.enable = pkgs.lib.mkForce true;
                clipboard-image.enable = pkgs.lib.mkForce false;
                markdown-preview.enable = pkgs.lib.mkForce true;
                commentary.enable = pkgs.lib.mkForce true;
                # Does not show in nikpgs, but is there under "vimPlugins.CopilotChat-nvim"
                # copilot-chat.enable = pkgs.lib.mkForce true;
                copilot-cmp.enable = pkgs.lib.mkForce false;
                diffview.enable = pkgs.lib.mkForce false;
                helm.enable = pkgs.lib.mkForce true;
                lazygit.enable = true;
                multicursors.enable = pkgs.lib.mkForce false;
                nix.enable = pkgs.lib.mkForce true;
                nix-develop.enable = pkgs.lib.mkForce true;
                nvim-colorizer.enable = pkgs.lib.mkForce true;
                obsidian.enable = pkgs.lib.mkForce false;
                todo-comments.enable = pkgs.lib.mkForce true;

              };
            };
          })
        ];
      };
    };
  };
}
