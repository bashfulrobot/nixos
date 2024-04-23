{ pkgs, config, libs, inputs, ... }:
let
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    # https://github.com/NixOS/nixos-hardware/blob/master/common/gpu/nvidia/default.nix
    extraPackages = with pkgs; [ vaapiVdpau ];
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    powerManagement.enable = false;
    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from diver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommened setting.
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    # package = config.boot.kernelPackages.nvidiaPackages.production;
    # Can select driver here:
    # https://github.com/NixOS/nixpkgs/blob/979a311fbd179b86200e412a3ed266b64808df4e/pkgs/os-specific/linux/nvidia-x11/default.nix#L36
    package = let
      rcu_patch = pkgs.fetchpatch {
        url =
          "https://github.com/gentoo/gentoo/raw/c64caf53/x11-drivers/nvidia-drivers/files/nvidia-drivers-470.223.02-gpl-pfn_valid.patch";
        hash = "sha256-eZiQQp2S/asE7MfGvfe6dA/kdCvek9SYa/FFGp24dVg=";
      };
    in config.boot.kernelPackages.nvidiaPackages.mkDriver {
      # version = "535.154.05";
      # sha256_64bit = "sha256-fpUGXKprgt6SYRDxSCemGXLrEsIA6GOinp+0eGbqqJg=";
      # sha256_aarch64 = "sha256-G0/GiObf/BZMkzzET8HQjdIcvCSqB1uhsinro2HLK9k=";
      # openSha256 = "sha256-wvRdHguGLxS0mR06P5Qi++pDJBCF8pJ8hr4T8O6TJIo=";
      # settingsSha256 = "sha256-9wqoDEWY4I7weWW05F4igj1Gj9wjHsREFMztfEmqm10=";
      # persistencedSha256 =
      #   "sha256-d0Q3Lk80JqkS1B54Mahu2yY/WocOqFFbZVBh+ToGhaE=";

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
          enableOffloadCmd = true;
      };

      # OR

      # sync.enable = true;

      # Make sure to use the correct Bus ID values for your system!
      # https://wiki.nixos.org/wiki/Nvidia#Configuring_Optimus_PRIME:_Bus_ID_Values_(Mandatory)
      # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA. ANd can match with: sudo lshw -c display
      # Note the two values under "bus info" above, which may differ from laptop to laptop. Our Nvidia Bus ID is 0e:00.0 and our Intel Bus ID is 00:02.0. Watch out for the formatting; convert them from hexadecimal to decimal, remove the padding (leading zeroes), replace the dot with a colon
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };

  };

  home-manager.users."${username}" = {

    home.packages = with pkgs; [
      # Nvidia settings
      gnomeExtensions.gpu-profile-selector
      inputs.envycontrol.packages.x86_64-linux.default
      glxinfo
    ];

    dconf.settings = with inputs.home-manager.lib.hm.gvariant; {
      # Gnome Extention - GPU Profile Selector
      "org/gnome/shell/extensions/GPU_profile_selector" = {
        rtd3 = true;
        force-composition-pipeline = true;
        coolbits = true;
        force-topbar-view = false;
      };
    };
  };
}
