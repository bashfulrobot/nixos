{ ... }: {
  programs.nixvim = {
    plugins.nvim-cmp = {
      enable = true;

      sources = [
        {
          name = "nvim_lsp";
          groupIndex = 1;
        }
        {
          name = "path";
          groupIndex = 1;
        }
        {
          name = "buffer";
          groupIndex = 2;
        }
      ];

      view.entries = {
        name = "custom";
        selection_order = "near_cursor";
      };

      mappingPresets = [ "insert" "cmdline" ];
      mapping = {
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-e>" = "cmp.mapping.abort()";
        "<CR>" =
          "cmp.mapping.confirm({ select = false })"; # Accept only explicitly selected items
        "<Tab>" = "cmp.mapping.select_next_item()";
        "<S-Tab>" = "cmp.mapping.select_prev_item()";
        "<M-u>" = "cmp.mapping.scroll_docs(-4)";
        "<M-d>" = "cmp.mapping.scroll_docs(4)";
      };
    };

    plugins.cmp-git.enable = true;
    plugins.cmp-cmdline.enable = true;
    # plugins.cmp-zsh.enable = true;
  };
}
