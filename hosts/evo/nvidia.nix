{ lib, pkgs, config, ... }:

{
  # NVIDIA drivers are unfree.
  nixpkgs.config.allowUnfree = true;
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
      extraPackages = with pkgs; [ vaapiVdpau intel-media-driver vaapiIntel libvdpau-va-gl ];
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
      # Note: As of early March 2024 the production driver has been updated from 535 to 550. This is a breaking change for some people, especially those on Wayland.
      # package = config.boot.kernelPackages.nvidiaPackages.production;
      #### Special config to load the latest 535 driver for the support of the 4070 SUPER
      # https://github.com/NixOS/nixpkgs/issues/289292
      package = let
        rcu_patch = pkgs.fetchpatch {
          url =
            "https://github.com/gentoo/gentoo/raw/c64caf53/x11-drivers/nvidia-drivers/files/nvidia-drivers-470.223.02-gpl-pfn_valid.patch";
          hash = "sha256-eZiQQp2S/asE7MfGvfe6dA/kdCvek9SYa/FFGp24dVg=";
        };
      in config.boot.kernelPackages.nvidiaPackages.mkDriver {
        # tested - https://github.com/NixOS/nixpkgs/blob/979a311fbd179b86200e412a3ed266b64808df4e/pkgs/os-specific/linux/nvidia-x11/default.nix#L36
        # https://github.com/NixOS/nixpkgs/blob/master/pkgs/os-specific/linux/nvidia-x11/default.nix to choose driver
        version = "550.40.07";
        sha256_64bit = "sha256-KYk2xye37v7ZW7h+uNJM/u8fNf7KyGTZjiaU03dJpK0=";
        sha256_aarch64 = "sha256-AV7KgRXYaQGBFl7zuRcfnTGr8rS5n13nGUIe3mJTXb4=";
        openSha256 = "sha256-mRUTEWVsbjq+psVe+kAT6MjyZuLkG2yRDxCMvDJRL1I=";
        settingsSha256 = "sha256-c30AQa4g4a1EHmaEu1yc05oqY01y+IusbBuq+P6rMCs=";
        persistencedSha256 =
          "sha256-11tLSY8uUIl4X/roNnxf5yS2PQvHvoNjnd2CB67e870=";

        patches = [ rcu_patch ];
      };
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true; # Provides `nvidia-offload` command.
        };
        # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
        intelBusId = "PCI:0:0:2";
        # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
        # nvidiaBusId = "PCI:1:0:0";
        nvidiaBusId = "PCI:0:1:0";
      };
    };
  };

}

#### NOTES
# Get BusID:
# lspci | rg "VGA|3D controller"
# it will be in hexadecimal format, convert it to decimal
# It is good to check the conversion with the following command:
# ❯ lspci -s 0:2:0
# 02:00.0 Non-Volatile memory controller: SK hynix Platinum P41/PC801 NVMe Solid State Drive
# ❯ lspci -s 0:1:0
# 01:00.0 3D controller: NVIDIA Corporation AD106M [GeForce RTX 4070 Max-Q / Mobile] (rev a1)
