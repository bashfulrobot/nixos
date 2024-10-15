{ config, pkgs, lib, ... }:
let cfg = config.suites.infrastructure;
in {

  options = {
    suites.infrastructure.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable infrastructure mgmt tooling..";
    };
  };

  config = lib.mkIf cfg.enable {

    apps = { kvm.enable = true; };
    cli = {
      tailscale.enable = true;
      docker.enable = true;
    };

    environment.systemPackages = with pkgs; [

      # --- Cloud
      #awscli2 # AWS command line interface
      # google-cloud-sdk # Google Cloud SDK
      aws-iam-authenticator # AWS IAM authentication tool

      #  --- IAS
      terraform # infrastructure as code tools
      cloud-utils # cloud management utilities
      cdrtools # mkisofs needed for cloud-init
      libxslt # A C library and tools to do XSL transformations - needed in my terraform scripts

      # --- Backup
      restic # backup program
      autorestic # restic automation tool

      # --- Other
      ctop # container process monitoring
	    wakeonlan 
];
  };
}
