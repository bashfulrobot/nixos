{ user-settings, pkgs, config, lib, ... }:
let
  cfg = config.apps.kvm;

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
      virt-viewer
      virt-manager
      spice
      spice-gtk
      spice-protocol
      win-virtio
      win-spice
    ];

    # Add user to libvirtd group
    users.users."${user-settings.user.username}".extraGroups =
      [ "libvirtd" "qemu" "kvm" "qemu-libvirtd" "lxd" ];

    virtualisation = {
      libvirtd = {
        enable = true;
        allowedBridges = [ "virbr0" "br0" "virbr1" "virbr2" "virbr3" "virbr4" "virbr5" "virbr6" "virbr7" ];
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
