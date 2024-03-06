{ lib, pkgs, config, ... }:

{
  # NVIDIA drivers are unfree.
  nixpkgs.config.allowUnfree = pkgs.lib.mkForce true;
  # Sets the default video driver for the X server and Wayland to "nvidia"
  services.xserver.videoDrivers = lib.mkDefault [ "nvidia" ];
  hardware = {
    opengl = {
      # Enables the graphics driver for OpenGL
      enable = true;
      # Enables Direct Rendering Infrastructure (DRI), which allows the graphics driver to directly render graphics, improving performance in OpenGL
      driSupport = true;
      # Enables 32-bit Direct Rendering Infrastructure (DRI) support, which allows the graphics driver to directly render graphics in 32-bit applications using OpenGL
      driSupport32Bit = true;
      # Adds the 'vaapiVdpau' package to the extra packages for OpenGL
      extraPackages = with pkgs; [ vaapiVdpau ];
    };
    nvidia = {
      # Enable the Nvidia driver.
      enable = true;
      # Modesetting is required.
      # Since NVIDIA does not support automatic KMS late loading, enabling DRM (Direct Rendering Manager) kernel mode setting is required to make Wayland compositors function properly, or to allow for Xorg#Rootless_Xorg.
      modesetting.enable = true;
      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      # Enable this if you have graphical corruption issues or application crashes after waking
      # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
      # of just the bare essentials.
      powerManagement.enable = false;
      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = false;
      # Use the NVidia open source kernel module (not to be confused with the
      # independent third-party "nouveau" open source driver).
      # Support is limited to the Turing and later architectures. Full list of
      # supported GPUs is at:
      # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
      # Only available from driver 515.43.04+
      # Currently alpha-quality/buggy, so false is currently the recommended setting.
      open = false;
      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
      nvidiaSettings = true;
      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true; # Provides `nvidia-offload` command.
        };
        # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
        intelBusId = "PCI:0:2:0";
        # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

}

#### NOTES
# Get BusID:
# lspci | rg "VGA|3D controller"
# it will be in hexadecimal format, convert it to decimal
# https://www.binaryhexconverter.com/hex-to-decimal-converter
