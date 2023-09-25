{ pkgs, ... }: {
  # Starship prompt
  # https://github.com/search?p=1&q=language%3Anix+programs.starship.settings&type=Code
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      add_newline = true;
      character = {
        success_symbol = "[λ](bold green)";
        error_symbol = "[λ](bold red)";
      };
      # format = builtins.concatStringsSep "" [
      #   "$username"
      #   "$hostname"
      #   "$shlvl"
      #   "$kubernetes"
      #   "$directory"
      #   # "$vcsh"
      #   "$git_branch"
      #   "$git_commit"
      #   "$git_state"
      #   "$git_status"
      #   # "$hg_branch"
      #   # "$docker_context"
      #   "$package"
      #   # "$cmake"
      #   # "$dart"
      #   # "$deno"
      #   # "$dotnet"
      #   "$elixir"
      #   # "$elm"
      #   "$erlang"
      #   "$golang"
      #   "$helm"
      #   "$java"
      #   # "$julia"
      #   # "$kotlin"
      #   # "$nim"
      #   "$nodejs"
      #   "$ocaml"
      #   "$perl"
      #   # "$php"
      #   "$purescript"
      #   "$python"
      #   # "$red"
      #   "$ruby"
      #   "$rust"
      #   # "$scala"
      #   # "$swift"
      #   "$terraform"
      #   # "$vagrant"
      #   # "$zig"
      #   "$nix_shell"
      #   # "$conda"
      #   "$memory_usage"
      #   "$aws"
      #   # "$gcloud"
      #   # "$openstack"
      #   "$env_var"
      #   # "$crystal"
      #   # "$custom"
      #   "$cmd_duration"
      #   # "$line_break"
      #   # "$lua"
      #   "$jobs"
      #   # "$battery"
      #   "$time"
      #   "$line_break" # added
      #   "$status"
      #   # "$shell"
      #   "$character"
      # ];
      # git_branch.symbol = "🌱 ";
      # git_commit.tag_disabled = false;
      # git_status = {
      #   ahead = "⇡\${count}";
      #   behind = "⇣\${count}";
      #   diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
      #   staged = "+$count";
      # };
      kubernetes.disabled = false;
      aws.disabled = true;
      nix_shell = {
        format = "via [$symbol$state]($style) ";
        impure_msg = "ι";
        pure_msg = "﻿ρ";
        symbol = "❄️";
      };
      time.disabled = true;
    };
  };
}
