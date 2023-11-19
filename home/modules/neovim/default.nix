{ pkgs, lib, ... }:
let
  # shadowenv-vim = pkgs.vimUtils.buildVimPluginFrom2Nix {
  shadowenv-vim = pkgs.vimUtils.buildVimPlugin {
    name = "shadowenv-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "Arkham";
      repo = "shadowenv.vim";
      rev = "6422c3a651c3788881d01556cb2a90bdff7bf002";
      hash = "sha256-M0Ii6s7Q4+wNajwz3bsWehG0HniOd/bUApSlNnubzNE=";
    };
  };

  # nix-prefetch-github numToStr Comment.nvim

  # with visual, use "gc", with numbers , "gcc". Ie "4gcc" to comment 4 lines

  comment-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "comment-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "numToStr";
      repo = "Comment.nvim";
      rev = "0236521ea582747b58869cb72f70ccfa967d2e89";
      hash = "sha256-+dF1ZombrlO6nQggufSb0igXW5zwU++o0W/5ZA07cdc=";
    };

  };

in {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [

      vim-nix
      vim-wayland-clipboard
      vim-surround
      leap-nvim
      neoformat
      fzf-vim
      lightline-vim
      shadowenv-vim
      comment-nvim
      neoscroll-nvim
      supertab
      tabular
      vim-commentary
      vim-endwise
      vim-fugitive
      vim-polyglot
      vim-rhubarb
      vim-visualstar
      vim-unimpaired
      vim-go
      gruvbox # theme
      nvim-web-devicons # theme related
    ];
    extraConfig = ''
      " Add the following augroup to run Neoformat on BufWritePre:
      augroup fmt
        autocmd!
        autocmd BufWritePre * undojoin | Neoformat
      augroup END

      " YAML documents are required to have a 2 space indentation
      autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

      " set clipboard options
      set clipboard^=unnamed,unnamedplus

      " Keyboard Options

      " Add FZF Key Mapping
      nnoremap <C-o> :Files<CR>

      " Save key mapping for Ctrl-S
      nnoremap <C-S> :write<CR>

      " Save and exit key mapping for Ctrl-X
      nnoremap <C-X> :wq<CR>

      " Map "gcc" for comments to my preferred Ctrl-L
      nnoremap <C-L> gc<CR>

      " color scheme
      colorscheme gruvbox
    '';

  };
}
