{ user-settings, pkgs, config, lib, ... }:
let cfg = config.cli.nixvim;

in {

  options = {
    cli.nixvim.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable nvim editor.";
    };
  };

  config = lib.mkIf cfg.enable {

    programs.nixvim = {
      enable = true;
      enableMan = false;
      viAlias = true;
      vimAlias = true;
      autoCmd = [
        {
          event = "VimEnter";
          command = "set nofoldenable";
          desc = "Unfold All";
        }
        {
          event = "BufWrite";
          command = "%s/\\s\\+$//e";
          desc = "Remove Whitespaces";
        }
        {
          event = "FileType";
          pattern = [ "markdown" "org" "norg" ];
          command = "setlocal conceallevel=2";
          desc = "Conceal Syntax Attribute";
        }
        {
          event = "FileType";
          pattern = [ "markdown" "org" "norg" ];
          command = "setlocal spell spelllang=en,nl";
          desc = "Spell Checking";
        }
        {
          event = "FileType";
          pattern = [ "markdown" ];
          command = "setlocal scrolloff=30 | setlocal wrap";
          desc =
            "Fixed cursor location on markdown (for preview) and enable wrapping";
        }
      ];

      opts = {
        number = true;
        relativenumber = true;
        hidden = true;
        foldlevel = 99;
        shiftwidth = 2;
        tabstop = 2;
        softtabstop = 2;
        expandtab = true;
        autoindent = true;
        wrap = false;
        scrolloff = 5;
        sidescroll = 40;
        completeopt = [ "menu" "menuone" "noselect" ];
        pumheight = 15;
        fileencoding = "utf-8";
        swapfile = false;
        timeoutlen = 2500;
        conceallevel = 3;
        cursorline = true;
        spell = false;
        spelllang = [ "en" ];
      };

      clipboard = {
        register = "unnamedplus";
        providers.wl-copy.enable = true;
      };

      globals = {
        mapleader = " ";
        maplocalleader = " ";
      };

      keymaps = [
        {
          key = "<C-s>";
          action = "<CMD>w<CR>";
          options.desc = "Save";
        }
        {
          key = "<leader>q";
          action = "<CMD>q<CR>";
          options.desc = "Quit";
        }
        {
          key = "<F2>";
          action = "<CMD>Neotree toggle<CR>";
          options.desc = "Toggle NeoTree";
        }
        {
          key = "<leader>e";
          action = "<CMD>Neotree toggle<CR>";
          options.desc = "Toggle NeoTree";
        }
        {
          key = "<leader>fs";
          action = "<CMD>Neotree toggle<CR>";
          options.desc = "Toggle NeoTree";
        }
        {
          key = "<F3>";
          action = "<CMD>UndotreeToggle<CR>";
          options.desc = "Toggle UndoTree";
        }
        {
          key = "<leader>sh";
          action = "<C-w>s";
          options.desc = "Split Horizontal";
        }
        {
          key = "<leader>sv";
          action = "<C-w>v";
          options.desc = "Split Vertical";
        }
        {
          key = "<leader><Left>";
          action = "<C-w>h";
          options.desc = "Select Window Left";
        }
        {
          key = "<leader>h";
          action = "<C-w>h";
          options.desc = "Select Window Left";
        }
        {
          key = "<leader><Right>";
          action = "<C-w>l";
          options.desc = "Select Window Right";
        }
        {
          key = "<leader>l";
          action = "<C-w>l";
          options.desc = "Select Window Right";
        }
        {
          key = "<leader><Down>";
          action = "<C-w>j";
          options.desc = "Select Window Below";
        }
        {
          key = "<leader>j";
          action = "<C-w>j";
          options.desc = "Select Window Below";
        }
        {
          key = "<leader><Up>";
          action = "<C-w>k";
          options.desc = "Select Window Above";
        }
        {
          key = "<leader>k";
          action = "<C-w>k";
          options.desc = "Select Window Above";
        }
        {
          key = "<leader>t";
          action = "<C-w>w";
          options.desc = "Cycle Between Windows";
        }
        {
          key = "<leader>bb";
          action = "<CMD>BufferPick<CR>";
          options.desc = "Select Buffer";
        }
        {
          key = "<leader>bc";
          action = "<CMD>BufferClose<CR>";
          options.desc = "Close Current Buffer";
        }
        {
          key = "<leader>bk";
          action = "<CMD>BufferClose<CR>";
          options.desc = "Close Current Buffer";
        }
        {
          key = "<leader>bn";
          action = "<CMD>:bnext<CR>";
          options.desc = "Next Buffer";
        }
        {
          key = "<leader>bp";
          action = "<CMD>:bprev<CR>";
          options.desc = "Previous Buffer";
        }
        {
          mode = "v";
          key = "<";
          action = "<gv";
          options.desc = "Tab Text Right";
        }
        {
          mode = "v";
          key = ">";
          action = ">gv";
          options.desc = "Tab Text Left";
        }
        {
          mode = "n";
          key = "<C-/>";
          action = "<Plug>(comment_toggle_linewise_current)";
          options.desc = "(Un)comment in Normal Mode";
        }
        {
          mode = "v";
          key = "<C-/>";
          action = "<Plug>(comment_toggle_linewise_visual)";
          options.desc = "(Un)comment in Visual Mode";
        }
        {
          mode = "n";
          key = "<C-S-/>";
          action = "<Plug>(comment_toggle_blockwise_current)";
          options.desc = "(Un)comment in Normal Mode";
        }
        {
          mode = "v";
          key = "<C-S-/>";
          action = "<Plug>(comment_toggle_blockwise_visual)";
          options.desc = "(Un)comment in Visual Mode";
        }
        {
          mode = "n";
          key = "gd";
          action = "<CMD>lua vim.lsp.buf.hover()<CR>";
          options.desc = "Show lsp definition in floating window";
        }
        {
          mode = "n";
          key = "gD";
          action = "<CMD>lua vim.lsp.buf.definition()<CR>";
          options.desc = "Load lsp definition in new buffer";
        }
        {
          mode = "n";
          key = "ge";
          action = "<CMD>lua vim.diagnostic.open_float()<CR>";
          options.desc = "Show lsp diagnostic in floating window";
        }
        {
          mode = "n";
          key = "<leader>r";
          action = ":! ";
          options.desc = "Run command";
        }
        {
          mode = "n";
          key = "<TAB>";
          action = "z=";
          options.desc = "Get spell suggestion";
        }
        {
          mode = "n";
          key = "\\\\";
          action = "<CMD>ToggleTerm<CR>";
          options.desc = "Toggle terminal";
        }
        {
          mode = "t";
          key = "<esc>";
          action = "<C-\\><C-n>";
          options.desc = "Exit terminal mode";
        }
      ];

      plugins = {
        lualine.enable = true;
        barbar.enable = true;
        gitgutter = {
          enable = true;
          defaultMaps = false;
        };
        mini = {
          enable = true;
          modules = {
            indentscope = { };
            move = { };
          };
        };
        indent-blankline = {
          enable = true;
          settings.scope.enabled = false;
        };
        lastplace.enable = true;
        comment.enable = true;
        fugitive.enable = true;
        markdown-preview.enable = true;
        nvim-autopairs.enable = true;
        telescope = {
          enable = true;
          settings = { pickers.find_files = { hidden = true; }; };
          keymaps = {
            "<leader>ff" = {
              action = "find_files";
              options = { desc = "Find File"; };
            };
            "<leader>fg" = {
              action = "live_grep";
              options = { desc = "Find Via Grep"; };
            };
            "<leader>fb" = {
              action = "buffers";
              options = { desc = "Find Buffers"; };
            };
            "<leader>fh" = {
              action = "help_tags";
              options = { desc = "Find Help"; };
            };
          };
        };
        neo-tree = {
          enable = true;
          window.width = 30;
          closeIfLastWindow = true;
          extraOptions = {
            filesystem = { filtered_items = { visible = true; }; };
          };
        };
        undotree = {
          enable = true;
          settings = {
            FocusOnToggle = true;
            HighlightChangedText = true;
          };
        };
        treesitter = {
          enable = true;
          nixvimInjections = true;
          folding = false;
          nixGrammars = true;
          settings = {
            ensure_installed = "all";
            highlight.enable = true;
            incremental_selection.enable = true;
            indent.enable = true;
          };
        };
        treesitter-refactor = { enable = true; };
        nvim-colorizer = {
          enable = true;
          userDefaultOptions = {
            css = true;
            tailwind = "both";
          };
        };
        cursorline = {
          enable = true;
          cursorline = {
            enable = true;
            number = true;
            timeout = 0;
          };
          cursorword = {
            enable = true;
            hl = { underline = true; };
            minLength = 3;
          };
        };
        lsp = {
          enable = true;
          servers = {
            nil-ls.enable = true;
            svelte.enable = true;
            html.enable = true;
            cssls.enable = true;
            eslint.enable = true;
            tsserver.enable = true;
            pyright.enable = true;
            tailwindcss = {
              enable = true;
              filetypes = [ "html" "js" "ts" "jsx" "tsx" "mdx" "svelte" ];
            };
            gopls.enable = true;
            # zls.enable = true;
          };
        };
        lsp-format.enable = true;
        none-ls = {
          enable = true;
          enableLspFormat = true;
          sources = {
            formatting = {
              prettier = {
                enable = true;
                disableTsServerFormatter = true;
              };
              nixpkgs_fmt.enable = true;
              markdownlint.enable = true;
            };
          };
        };
        lspkind = {
          enable = true;
          cmp = {
            enable = true;
            menu = {
              nvim_lsp = "[LSP]";
              nvim_lua = "[api]";
              path = "[path]";
              luasnip = "[snip]";
              look = "[look]";
              buffer = "[buffer]";
            };
          };
        };
        lsp-lines.enable = true;
        luasnip.enable = true;
        cmp_luasnip.enable = true;
        cmp-nvim-lsp.enable = true;
        cmp-look.enable = true;
        cmp = {
          enable = true;
          settings = {
            snippet.expand = "luasnip";
            mapping = {
              "<C-d>" = "cmp.mapping.scroll_docs(-4)";
              "<C-f>" = "cmp.mapping.scroll_docs(4)";
              "<C-Space>" = "cmp.mapping.complete()";
              "<C-e>" = "cmp.mapping.close()";
              # "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
              # "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
              "<Down>" =
                "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
              "<Up>" =
                "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
              "<C-j>" =
                "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
              "<C-k>" =
                "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
              "<Tab>" = "cmp.mapping.confirm({ select = true })";
            };
            sources = [
              { name = "nvim_lsp"; }
              { name = "luasnip"; }
              {
                name = "look";
                keywordLength = 2;
                option = {
                  convert_case = true;
                  loud = true;
                };
              }
              { name = "path"; }
              { name = "buffer"; }
              { name = "nvim_lua"; }
            ];
            window = {
              completion.border = "rounded";
              documentation.border = "rounded";
            };
            completion.completeopt = "menu,menuone,noselect,preview";
          };
        };
        which-key = {
          enable = true;
          settings = {
            spec = [
              {
                __unkeyed-1 = "<leader>b";
                desc = "Buffer";
              }
              {
                __unkeyed-1 = "<leader>f";

                desc = "Find";
              }
              {
                __unkeyed-1 = "<leader>s";
                desc = "Split Window";
              }
            ];
          };
        };
        toggleterm = {
          enable = true;
          settings = {
            autoScroll = true;
            closeOnExit = true;
            direction = "horizontal";
            persistMode = true;
            startInInsert = true;
          };
        };
      };
      extraPlugins = with pkgs.vimPlugins; [
        friendly-snippets
        luasnip
        nvim-scrollbar
        orgmode
        onedarkpro-nvim
        vim-cool
        vim-prettier
        (pkgs.vimUtils.buildVimPlugin rec {
          pname = "scope-nvim";
          version = "cd27af77ad61a7199af5c28d27013fb956eb0e3e";
          src = pkgs.fetchFromGitHub {
            owner = "tiagovla";
            repo = "scope.nvim";
            rev = version;
            sha256 = "sha256-z1ytdhxKrLnZG8qMPEe2h+wC9tF4K/x6zplwnIojZuE=";
          };
        })
        (pkgs.vimUtils.buildVimPlugin rec {
          pname = "follow-md-links.nvim";
          version = "cf081a0a8e93dd188241a570b9a700b6a546ad1c";
          src = pkgs.fetchFromGitHub {
            owner = "jghauser";
            repo = "follow-md-links.nvim";
            rev = version;
            sha256 = "sha256-ElgYrD+5FItPftpjDTdKAQR37XBkU8mZXs7EmAwEKJ4=";
          };
        })
      ];
    };

    home-manager.users."${user-settings.user.username}" = {
      home = {

        sessionVariables = { EDITOR = "nvim"; };

      };
    };
  };
}