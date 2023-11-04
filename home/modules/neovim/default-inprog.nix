# https://github.com/Sironheart/nix-config/tree/9a41a1eaa4cf1b43659346df211194acdd639b6a/home/programs/nixvim
{ lib, ... }: {
  imports = [ ./completion.nix ./lsp.nix ./plugins.nix ];

  lib.nixvim = {
    # Helper function to create leader mappings under a prefix
    mkLeaderMappings = prefix:
      lib.mapAttrs' (key: action:
        lib.nameValuePair "<Leader>${prefix}${key}" {
          silent = true;
          inherit action;
        });
  };

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    options = {
      number = true;
      cursorline = true;
      title = true;
      updatetime = 0;
      inccommand = "nosplit";
      smartcase = true;
      undofile = true;
    };

    # <Tab> through completions
    maps.insert."<Tab>" = {
      expr = true;
      action = ''pumvisible() ? "\<C-n>" : "\<Tab>"'';
    };
    maps.insert."<S-Tab>" = {
      expr = true;
      action = ''pumvisible() ? "\<C-p>" : "\<S-Tab>"'';
    };

    # Mappings to work with the OS clipboard
    maps.normalVisualOp."gy" = ''"+y'';
    maps.normalVisualOp."gp" = ''"+p'';
    maps.normalVisualOp."gP" = ''"+P'';

    colorschemes.onedark.enable = true;
  };
}
