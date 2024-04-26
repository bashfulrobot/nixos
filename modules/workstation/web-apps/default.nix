{ ... }:
let
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {
  home-manager.users."${username}" = {
    home.file."sysdig-mail.desktop" = {
      source = ./desktop-files/sysdig-mail.desktop;
      target = ".local/share/applications/sysdig-mail.desktop";
    };

    home.file."sysdig-lab-monitor.desktop" = {
      source = ./desktop-files/sysdig-lab-monitor.desktop;
      target = ".local/share/applications/sysdig-lab-monitor.desktop";
    };

    home.file."sysdig-lab-secure.desktop" = {
      source = ./desktop-files/sysdig-lab-secure.desktop;
      target = ".local/share/applications/sysdig-lab-secure.desktop";
    };

    home.file."br-mail.desktop" = {
      source = ./desktop-files/br-mail.desktop;
      target = ".local/share/applications/br-mail.desktop";
    };

    home.file."gmail.png" = {
      source = ./icons/gmail.png;
      target = ".local/share/xdg-desktop-portal/icons/192x192/gmail.png";
    };

    home.file."sysdig-calendar.desktop" = {
      source = ./desktop-files/sysdig-calendar.desktop;
      target = ".local/share/applications/sysdig-calendar.desktop";
    };

    home.file."google-calendar.svg" = {
      source = ./icons/google-calendar.svg;
      target = ".local/share/xdg-desktop-portal/icons/192x192/google-calendar.svg";
    };

    home.file."sysdig-drive.desktop" = {
      source = ./desktop-files/sysdig-drive.desktop;
      target = ".local/share/applications/sysdig-drive.desktop";
    };

    home.file."drive.png" = {
      source = ./icons/drive.png;
      target = ".local/share/xdg-desktop-portal/icons/192x192/drive.png";
    };

    home.file."claudeai.desktop" = {
      source = ./desktop-files/claudeai.desktop;
      target = ".local/share/applications/claudeai.desktop";
    };

    home.file."claudeai.svg" = {
      source = ./icons/claudeai.svg;
      target = ".local/share/xdg-desktop-portal/icons/192x192/claudeai.svg";
    };

    home.file."vitally.desktop" = {
      source = ./desktop-files/vitally.desktop;
      target = ".local/share/applications/vitally.desktop";
    };

    home.file."vitally.png" = {
      source = ./icons/vitally.png;
      target = ".local/share/xdg-desktop-portal/icons/192x192/vitally.png";
    };

    home.file."github.desktop" = {
      source = ./desktop-files/github.desktop;
      target = ".local/share/applications/github.desktop";
    };

    home.file."github-code-search.desktop" = {
      source = ./desktop-files/github-code-search.desktop;
      target = ".local/share/applications/github-code-search.desktop";
    };

    home.file."github.png" = {
      source = ./icons/github.png;
      target = ".local/share/xdg-desktop-portal/icons/192x192/github.png";
    };

    home.file."gong.desktop" = {
      source = ./desktop-files/gong.desktop;
      target = ".local/share/applications/gong.desktop";
    };

    home.file."gong.png" = {
      source = ./icons/gong.png;
      target = ".local/share/xdg-desktop-portal/icons/192x192/gong.png";
    };

    home.file."grammarly.desktop" = {
      source = ./desktop-files/grammarly.desktop;
      target = ".local/share/applications/grammarly.desktop";
    };

    home.file."grammarly.png" = {
      source = ./icons/grammarly.png;
      target = ".local/share/xdg-desktop-portal/icons/192x192/grammarly.png";
    };

    home.file."intercom.desktop" = {
      source = ./desktop-files/intercom.desktop;
      target = ".local/share/applications/intercom.desktop";
    };

    home.file."intercom.png" = {
      source = ./icons/intercom.png;
      target = ".local/share/xdg-desktop-portal/icons/192x192/intercom.png";
    };

    home.file."linkedin.desktop" = {
      source = ./desktop-files/linkedin.desktop;
      target = ".local/share/applications/linkedin.desktop";
    };

    home.file."linkedin.png" = {
      source = ./icons/linkedin.png;
      target = ".local/share/xdg-desktop-portal/icons/192x192/linkedin.png";
    };

    home.file."nixpkgs.desktop" = {
      source = ./desktop-files/nixpkgs.desktop;
      target = ".local/share/applications/nixpkgs.desktop";
    };

    home.file."nix-discourse.desktop" = {
      source = ./desktop-files/nix-discourse.desktop;
      target = ".local/share/applications/nix-discourse.desktop";
    };
    home.file."flakehub.desktop" = {
      source = ./desktop-files/flakehub.desktop;
      target = ".local/share/applications/flakehub.desktop";
    };

    home.file."home-manager.desktop" = {
      source = ./desktop-files/home-manager.desktop;
      target = ".local/share/applications/home-manager.desktop";
    };

    home.file."nix.png" = {
      source = ./icons/nix.png;
      target = ".local/share/xdg-desktop-portal/icons/192x192/nix.png";
    };

    home.file."tactiq.desktop" = {
      source = ./desktop-files/tactiq.desktop;
      target = ".local/share/applications/tactiq.desktop";
    };

    home.file."tactiq.png" = {
      source = ./icons/tactiq.png;
      target = ".local/share/xdg-desktop-portal/icons/192x192/tactiq.png";
    };

    # home.file."teams.desktop" = {
    #   source = ./desktop-files/teams.desktop;
    #   target = ".local/share/applications/teams.desktop";
    # };

    # home.file."teams.png" = {
    #   source = ./icons/teams.png;
    #   target = ".local/share/xdg-desktop-portal/icons/192x192/teams.png";
    # };

    # home.file."elk.desktop" = {
    #   source = ./desktop-files/elk.desktop;
    #   target = ".local/share/applications/elk.desktop";
    # };

    # home.file."elk.png" = {
    #   source = ./icons/elk.png;
    #   target = ".local/share/xdg-desktop-portal/icons/192x192/elk.png";
    # };

    home.file."chatgpt.desktop" = {
      source = ./desktop-files/chatgpt.desktop;
      target = ".local/share/applications/chatgpt.desktop";
    };

    home.file."chatgpt.svg" = {
      source = ./icons/chatgpt.svg;
      target = ".local/share/xdg-desktop-portal/icons/192x192/chatgpt.svg";
    };

    # home.file."languagetool.desktop" = {
    #   source = ./desktop-files/languagetool.desktop;
    #   target = ".local/share/applications/languagetool.desktop";
    # };

    # home.file."languagetool.png" = {
    #   source = ./icons/languagetool.png;
    #   target = ".local/share/xdg-desktop-portal/icons/192x192/languagetool.png";
    # };

    home.file."zoom-recordings.desktop" = {
      source = ./desktop-files/zoom-recordings.desktop;
      target = ".local/share/applications/zoom-recordings.desktop";
    };

    home.file."zoom.png" = {
      source = ./icons/zoom.png;
      target = ".local/share/xdg-desktop-portal/icons/192x192/zoom.png";
    };

    home.file."google.desktop" = {
      source = ./desktop-files/google.desktop;
      target = ".local/share/applications/google.desktop";
    };

    home.file."google.png" = {
      source = ./icons/google.png;
      target = ".local/share/xdg-desktop-portal/icons/192x192/google.png";
    };

    home.file."pocketcasts.desktop" = {
      source = ./desktop-files/pocketcasts.desktop;
      target = ".local/share/applications/pocketcasts.desktop";
    };

    home.file."pocketcasts.png" = {
      source = ./icons/pocketcasts.png;
      target = ".local/share/xdg-desktop-portal/icons/192x192/pocketcasts.png";
    };

    home.file."duckduckgo.desktop" = {
      source = ./desktop-files/duckduckgo.desktop;
      target = ".local/share/applications/duckduckgo.desktop";
    };

    home.file."duckduckgo.svg" = {
      source = ./icons/duckduckgo.svg;
      target = ".local/share/xdg-desktop-portal/icons/192x192/duckduckgo.svg";
    };

    home.file."salesforce.desktop" = {
      source = ./desktop-files/salesforce.desktop;
      target = ".local/share/applications/salesforce.desktop";
    };

    home.file."salesforce.png" = {
      source = ./icons/salesforce.png;
      target = ".local/share/xdg-desktop-portal/icons/192x192/salesforce.png";
    };

    home.file."sysdig-docs.desktop" = {
      source = ./desktop-files/sysdig-docs.desktop;
      target = ".local/share/applications/sysdig-docs.desktop";
    };

    home.file."sysdig.png" = {
      source = ./icons/sysdig.png;
      target = ".local/share/xdg-desktop-portal/icons/192x192/sysdig.png";
    };

    home.file."fr-project.desktop" = {
      source = ./desktop-files/fr-project.desktop;
      target = ".local/share/applications/fr-project.desktop";
    };

    home.file."asana-logo.svg" = {
      source = ./icons/asana-logo.svg;
      target = ".local/share/xdg-desktop-portal/icons/192x192/asana-logo.svg";
    };

    home.file."miro.desktop" = {
      source = ./desktop-files/miro.desktop;
      target = ".local/share/applications/miro.desktop";
    };

    home.file."miro.svg" = {
      source = ./icons/miro.svg;
      target = ".local/share/xdg-desktop-portal/icons/192x192/miro.svg";
    };

    # home.file."gemini.desktop" = {
    #   source = ./desktop-files/gemini.desktop;
    #   target = ".local/share/applications/gemini.desktop";
    # };

    # home.file."br-jira.desktop" = {
    #   source = ./desktop-files/br-jira.desktop;
    #   target = ".local/share/applications/br-jira.desktop";
    # };

    # home.file."jira.png" = {
    #   source = ./icons/jira.png;
    #   target = ".local/share/xdg-desktop-portal/icons/192x192/jira.png";
    # };

    home.file."jira.desktop" = {
      source = ./desktop-files/jira.desktop;
      target = ".local/share/applications/jira.desktop";
    };

    home.file."jira.png" = {
      source = ./icons/jira.png;
      target = ".local/share/xdg-desktop-portal/icons/192x192/jira.png";
    };

    home.file."confluence.desktop" = {
      source = ./desktop-files/confluence.desktop;
      target = ".local/share/applications/confluence.desktop";
    };

    home.file."confluence.svg" = {
      source = ./icons/confluence.svg;
      target = ".local/share/xdg-desktop-portal/icons/192x192/confluence.svg";
    };

    home.file."syncthing.desktop" = {
      source = ./desktop-files/syncthing.desktop;
      target = ".local/share/applications/syncthing.desktop";
    };

    home.file."syncthing.png" = {
      source = ./icons/syncthing.png;
      target = ".local/share/xdg-desktop-portal/icons/192x192/syncthing.png";
    };
  };
}
