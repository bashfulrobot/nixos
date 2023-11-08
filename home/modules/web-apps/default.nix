{ config, lib, pkgs, ... }:

{

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

  home.file."calendar.png" = {
    source = ./icons/calendar.png;
    target = ".local/share/xdg-desktop-portal/icons/192x192/calendar.png";
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

  home.file."claudeai.png" = {
    source = ./icons/claudeai.png;
    target = ".local/share/xdg-desktop-portal/icons/192x192/claudeai.png";
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

  home.file."teams.desktop" = {
    source = ./desktop-files/teams.desktop;
    target = ".local/share/applications/teams.desktop";
  };

  home.file."teams.png" = {
    source = ./icons/teams.png;
    target = ".local/share/xdg-desktop-portal/icons/192x192/teams.png";
  };

  home.file."elk.desktop" = {
    source = ./desktop-files/elk.desktop;
    target = ".local/share/applications/elk.desktop";
  };

  home.file."elk.png" = {
    source = ./icons/elk.png;
    target = ".local/share/xdg-desktop-portal/icons/192x192/elk.png";
  };

  home.file."chatgpt.desktop" = {
    source = ./desktop-files/chatgpt.desktop;
    target = ".local/share/applications/chatgpt.desktop";
  };

  home.file."chatgpt.png" = {
    source = ./icons/chatgpt.png;
    target = ".local/share/xdg-desktop-portal/icons/192x192/chatgpt.png";
  };

  home.file."languagetool.desktop" = {
    source = ./desktop-files/languagetool.desktop;
    target = ".local/share/applications/languagetool.desktop";
  };

  home.file."languagetool.png" = {
    source = ./icons/languagetool.png;
    target = ".local/share/xdg-desktop-portal/icons/192x192/languagetool.png";
  };

  home.file."zoom-web.desktop" = {
    source = ./desktop-files/zoom-web.desktop;
    target = ".local/share/applications/zoom-web.desktop";
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

  home.file."br-jira.desktop" = {
    source = ./desktop-files/br-jir.desktop;
    target = ".local/share/applications/br-jir.desktop";
  };

  home.file."jira.png" = {
    source = ./icons/jira.png;
    target = ".local/share/xdg-desktop-portal/icons/192x192/jira.png";
  };

}
