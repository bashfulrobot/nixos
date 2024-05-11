{ pkgs, config, lib, ... }:
let
  cfg = config.apps.kvm;
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {

  options = {
    apps.kvm.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable KVM and virt manager.";
    };
  };

  config = lib.mkIf cfg.enable {

    # Install necessary packages
    environment.systemPackages = with pkgs; [
      virt-manager
      virt-viewer
      spice
      spice-gtk
      spice-protocol
      win-virtio
      win-spice
    ];

    # Add user to libvirtd group
    users.users."${username}".extraGroups =
      [ "libvirtd" "qemu" "kvm" "qemu-libvirtd" "lxd" ];

    virtualisation = {
      libvirtd = {
        enable = true;
        allowedBridges = [ "virbr0" "br0" ];
        onBoot = "start";
        onShutdown = "suspend";
        # https://github.com/tompreston/qemu-ovmf-swtpm
        # qemu = {
        #   swtpm.enable = true;
        #   ovmf.enable = true;
        #   ovmf.packages = [ pkgs.OVMFFull.fd ];
        # };
      };

      spiceUSBRedirection.enable = true;

    };
    services.spice-vdagentd.enable = true;

  };
}
