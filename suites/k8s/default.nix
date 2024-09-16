{ config, pkgs, lib, user-settings, ... }:
let cfg = config.suites.k8s;
in {

  options = {
    suites.k8s.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable k8s tooling..";
    };
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      eksctl # AWS EKS management tool
      cilium-cli # cilium cli
      kustomize # Kubernetes configuration management
      k0sctl # A bootstrapping and management tool for k0s clusters.
      # vagrant # lab automation
      fluxcd # FluxCD Gitops Cli
      # argocd-autopilot # https://argocd-autopilot.readthedocs.io/en/stable/
      # argocd # Gitops - cli
      # kubeone # Kubernetes cluster management
      talosctl # Talos OS management tool - diabled until https://github.com/NixOS/nixpkgs/issues/264127 is fixed.
      kompose # Kubernetes container orchestration
      # vultr-cli # Vultr cloud management
      kubectl # Kubernetes command-line tool
      kubectx # Kubernetes context switcher
      kubecolor # colorize kubectl output
      kubernetes-helm # Kubernetes package manager
      # butane # flatcar/ignition configuration

    ];
    home-manager.users."${user-settings.user.username}" = {
      programs = { k9s = { enable = true; }; };
    };
  };
}
