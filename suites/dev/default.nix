{ config, pkgs, lib, user-settings, ... }:
let cfg = config.suites.dev;
in {

  options = {
    suites.dev.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable dev tooling..";
    };
  };

  config = lib.mkIf cfg.enable {
    dev = {
      go.enable = true;
      npm.enable = true;
      python.enable = true;
      nix.enable = true;
    };

    apps = {
      vscode.enable = true;
      nixpkgs-search.enable = true;
      nixos-discourse.enable = true;
      nixos-wiki.enable = true;
      hm-search.enable = true;
      github-code-search.enable = true;
      github.enable = true;
    };

    cli = {
      direnv.enable = true;
      git.enable = true;
      nixvim.enable = true;
      nvim.enable = false;
      helix.enable = false;
    };

    environment.systemPackages = with pkgs; [
      zed-editor # text editor
      watchman # file watcher
      # gitnuro # git client
      # zola # static site generator
      pkg-config # allows packages to find out information about other packages
      httpie # HTTP client
      just # command runner
      # doppler # secret management tool
      nodejs-18_x # JavaScript runtime
      shadowenv # environment variable manager
      ghostscript # PostScript and PDF interpreter
      hugo # static site generator
      shfmt # shell script formatter
      # lapce # editor written in Rust
      cosmic-edit # editor from system 76
      #openvscode-server # vscode in browser. Used for demos
      jnv # json filtering with jq
    ];
    home-manager.users."${user-settings.user.username}" = {
      programs = { jq = { enable = true; }; };
    };
  };
}
