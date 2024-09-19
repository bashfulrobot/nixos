{ config, pkgs, ... }: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dustin = {
    isNormalUser = true;
    description = "Dustin Krysak";
    extraGroups = [ "docker" "wheel" "kvm" "qemu-libvirtd" "libvirtd" "networkmanager" ];
    shell = "/run/current-system/sw/bin/fish";
  };

}
