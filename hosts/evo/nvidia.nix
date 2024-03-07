{ lib, pkgs, config, ... }:

{
  # NVIDIA drivers are unfree.
  nixpkgs.config.allowUnfree = pkgs.lib.mkForce true;
  # Sets the default video driver for the X server and Wayland to "nvidia"
  services.xserver.videoDrivers = [ "nvidia" ];
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
      ## Confirmed my card is in there.
      open = false;
      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
      nvidiaSettings = true;
      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      package = config.boot.kernelPackages.nvidiaPackages.production;
      #### Special config to load the latest 535 driver for the support of the 4070 SUPER
      # https://github.com/NixOS/nixpkgs/issues/289292
      # package = let
      #   rcu_patch = pkgs.fetchpatch {
      #     url =
      #       "https://github.com/gentoo/gentoo/raw/c64caf53/x11-drivers/nvidia-drivers/files/nvidia-drivers-470.223.02-gpl-pfn_valid.patch";
      #     hash = "sha256-eZiQQp2S/asE7MfGvfe6dA/kdCvek9SYa/FFGp24dVg=";
      #   };
      # in config.boot.kernelPackages.nvidiaPackages.mkDriver {
      #   version = "535.154.05";
      #   sha256_64bit = "sha256-fpUGXKprgt6SYRDxSCemGXLrEsIA6GOinp+0eGbqqJg=";
      #   sha256_aarch64 = "sha256-G0/GiObf/BZMkzzET8HQjdIcvCSqB1uhsinro2HLK9k=";
      #   openSha256 = "sha256-wvRdHguGLxS0mR06P5Qi++pDJBCF8pJ8hr4T8O6TJIo=";
      #   settingsSha256 = "sha256-9wqoDEWY4I7weWW05F4igj1Gj9wjHsREFMztfEmqm10=";
      #   persistencedSha256 =
      #     "sha256-d0Q3Lk80JqkS1B54Mahu2yY/WocOqFFbZVBh+ToGhaE=";

      #   patches = [ rcu_patch ];
      # };
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
