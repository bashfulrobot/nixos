{ config, ... }:
let inherit (config.lib.nixvim) mkLeaderMappings;
in {
  programs.nixvim = {
    plugins.lsp = {
      enable = true;

      servers = {
        # Nix
        nil_ls = {
          enable = true;
          settings = { formatting.command = [ "alejandra" ]; };
        };

        # Java
        java-language-server.enable = true;

        # Kotlin
        kotlin-language-server.enable = true;

        # Terraform
        terraformls.enable = true;

        rust-analyzer.enable = true;

        # TypeScript
        tsserver.enable = true;
      };
    };

    plugins.lspsaga = {
      enable = true;

      # Don't show action icon in signcolumn
      lightbulb.sign = false;

      # Turn off breadcrumbs
      symbolInWinbar.enable = false;
    };

    plugins.lspkind = {
      enable = true;
      preset = "codicons";
      mode = "symbol";
    };

    maps.normal = {
      K = {
        silent = true;
        action = ":Lspsaga hover_doc<CR>";
      };
      "gd" = {
        silent = true;
        action = ":Lspsaga peek_definition<CR>";
      };
    } // mkLeaderMappings "l" {
      "r" = ":Lspsaga rename<CR>";
      "o" = ":Lspsaga outline<CR>";
      "f" = ":Lspsaga finder<CR>";
      "a" = ":Lspsaga code_action<CR>";
      "d" = ":Lspsaga show_buf_diagnostics<CR>";
      "D" = ":Lspsaga show_workspace_diagnostics<CR>";
    };
  };
}
