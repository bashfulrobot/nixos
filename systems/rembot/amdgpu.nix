{ config, pkgs, ... }:
{
  # The kernel can load the correct driver right away: 
  boot.initrd.kernelModules = [ "amdgpu" ];
  # Make sure Xserver uses the `amdgpu` driver
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  # Enable Vulkan
  hardware.opengl.driSupport = true;
  # For 32 bit applications
  hardware.opengl.driSupport32Bit = true;
}
