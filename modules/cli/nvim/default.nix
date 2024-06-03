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
      description = "Enable jeezyvim editor.";
    };
  };

  config = lib.mkIf cfg.enable {

    home-manager.users."${username}" = {
      home = {

        packages = with pkgs;
          [
            jeezyvim # opinionated neovim
          ];

        sessionVariables = { EDITOR = "nvim"; };

        # packages = [
        #   (pkgs.jeezyvim.nixvimExtend {
        #     # you can put anything under the "Options" section of the NixVim docs here
        #     # https://nix-community.github.io/nixvim/

        #     # some examples...

        #     # all your regular vim options here
        #     options = { textwidth = 120; };

        #     # add your own personal keymaps preferences
        #     keymaps = [

        #       # toggle comments
        #       {
        #         mode = "n";
        #         action = ":CommentToggle<CR>";
        #         key = "<Space>/";
        #       }
        #       # toggle copilot-chat
        #       {
        #         mode = "n";
        #         action = ":CopilotChatToggle<CR>";
        #         key = "<Space>c";
        #       }
        #       # explain the active selection
        #       {
        #         mode = "n";
        #         action = ":CopilotChatExplain<CR>";
        #         key = "<Leader>e";
        #       }
        #       # review the selected code
        #       {
        #         mode = "n";
        #         action = ":CopilotChatReview<CR>";
        #         key = "<Leader>r";
        #       }
        #       # fix the selected code
        #       {
        #         mode = "n";
        #         action = ":CopilotChatFix<CR>";
        #         key = "<Leader>f";
        #       }
        #       # optimize the selected code
        #       {
        #         mode = "n";
        #         action = ":CopilotChatOptimize<CR>";
        #         key = "<Leader>o";
        #       }
        #       # add documentation for the selection
        #       {
        #         mode = "n";
        #         action = ":CopilotChatDocs<CR>";
        #         key = "<Leader>d";
        #       }
        #       # generate tests for the code
        #       {
        #         mode = "n";
        #         action = ":CopilotChatTests<CR>";
        #         key = "<Leader>t";
        #       }
        #       # {
        #       #   mode = "n";
        #       #   action = ":vsplit<CR>";
        #       #   key = "|";
        #       # }

        #       # {
        #       #   mode = "n";
        #       #   action = ":split<CR>";
        #       #   key = "-";
        #       # }
        #     ];

        #     plugins = {
        #       lsp.servers = {
        #         # full list of language servers you can enable on the left bar here:
        #         # https://nix-community.github.io/nixvim/plugins/lsp/servers/ansiblels/index.html
        #         bashls.enable = true;
        #         docker-compose-language-service.enable = true;
        #         dockerls.enable = false;
        #         gopls.enable = false;
        #         graphql.enable = false;
        #         helm-ls.enable = false;
        #         html.enable = false;
        #         htmx.enable = false;
        #         jsonls.enable = false;
        #         marksman.enable = false;
        #         nginx-language-server.enable = false;
        #         nixd.enable = false;
        #         pylsp.enable = false;
        #         rust-analyzer.enable = false;
        #         svelte.enable = false;
        #         tailwindcss.enable = false;
        #         terraformls.enable = false;
        #         yamlls.enable = false;
        #       };

        #       # full list of plugins on the left bar here:
        #       # https://nix-community.github.io/nixvim/plugins/airline/index.html

        #       # readme - for config: https://github.com/m4xshen/autoclose.nvim?tab=readme-ov-file#-configuration
        #       autoclose.enable = false;
        #       clipboard-image.enable = false;
        #       markdown-preview.enable = false;
        #       copilot-chat.enable = false;
        #       copilot-cmp.enable = false;
        #       diffview.enable = false;
        #       helm.enable = false;
        #       lazygit.enable = true;
        #       multicursors.enable = false;
        #       nix.enable = false;
        #       nix-develop.enable  = false;
        #       nvim-colorizer.enable = false;
        #       obsidian.enable = false;
        #       todo-comments.enable = false;
        #     };
        #   })
        # ];
      };
    };
  };
}
