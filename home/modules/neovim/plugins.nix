{ pkgs, ... }: {
  programs.nixvim = {
    plugins.indent-blankline.enable = true;

    plugins.gitsigns = {
      enable = true;
      currentLineBlame = true;
    };

    plugins.telescope.enable = true;

    plugins.treesitter = {
      enable = true;
      folding = false;
      indent = true;
      nixvimInjections = true;
      incrementalSelection.enable = true;
    };

    plugins.treesitter-context = {
      enable = true;
      maxLines = 2;
      minWindowHeight = 100;
    };

    plugins.comment-nvim.enable = true;

    plugins.which-key.enable = true;

    plugins.nvim-autopairs = {
      enable = true;
      checkTs = true;
      mapBs = true;
      mapCW = true;
    };

    plugins.lualine = {
      enable = true;
      componentSeparators = {
        left = "";
        right = "";
      };
      sectionSeparators = {
        left = "";
        right = "";
      };
      iconsEnabled = false;

      sections = {
        # Only show the first char of the current mode
        lualine_a = [
          {
            name = "mode";
            extraConfig.fmt.__raw = "function(str) return str:sub(1,1) end";
          }
          "selectioncount"
        ];
        lualine_b = [ "branch" "diff" ];
        lualine_c = [{
          name = "filename";
          extraConfig.path = 1;
        }];

        lualine_x = [ "diagnostics" "filetype" ];
        lualine_y = [ "progress" "searchcount" ];
        lualine_z = [ "location" ];
      };

      tabline = {
        lualine_a = [{
          name = "windows";
          extraConfig.windows_color = {
            active = "lualine_a_normal";
            inactive = "lualine_b_inactive";
          };
        }];
        lualine_z = [{
          name = "tabs";
          extraConfig.tabs_color = {
            active = "lualine_a_normal";
            inactive = "lualine_b_inactive";
          };
        }];
      };
    };

    plugins.nvim-tree = {
      enable = true;

      autoClose = true;
      disableNetrw = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      sensible # Sensible defaults
      repeat # Repeatable plugin actions
      easy-align # Align text around symbols
      vim-be-good
    ];
  };
}
