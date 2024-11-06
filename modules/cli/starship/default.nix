{ user-settings, pkgs, secrets, config, lib, ... }:
let cfg = config.cli.starship;

in {
  options = {
    cli.starship.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable starship prompt.";
    };
  };

  config = lib.mkIf cfg.enable {

    # environment.systemPackages = with pkgs; [
    #
    #  ];

    home-manager.users."${user-settings.user.username}" = {
      programs.starship = {
        enable = true;
        enableZshIntegration = true;
        enableFishIntegration = true;
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

    };
  };
}
