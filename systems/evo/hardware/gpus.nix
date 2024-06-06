{ pkgs, config, lib, inputs, ... }: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia

    # TODO: why do I get the below error?
    # error: The option `hardware.intelgpu.loadInInitrd' in `/nix/store/4mgg9mrh8g0qj4g3z9zvqhrniig10bsn-source/systems/evo/hardware/gpus.nix' is already declared in `/nix/store/75hvhrfigcnckibdlg877157bpwjmy85-source/common/gpu/intel'.
    # Where is the other coming from?g
    # inputs.nixos-hardware.nixosModules.common-gpu-intel
  ];

  boot = {
    blacklistedKernelModules = lib.mkDefault [ "nouveau" ];
    kernelModules = [ "kvm-intel" "nvidia" ];
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = [ pkgs.intel-media-driver ];
    };

    nvidia = {
      # Modesetting is required.
      modesetting.enable = true;

      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      package = config.boot.kernelPackages.nvidiaPackages.beta;

      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      # Enable this if you have graphical corruption issues or application crashes after waking
      # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
      # of just the bare essentials.
      powerManagement.enable = true;

      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = true;

      # Use the NVidia open source kernel module (not to be confused with the
      # independent third-party "nouveau" open source driver).
      # Support is limited to the Turing and later architectures. Full list of
      # supported GPUs is at:
      # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
      # Only available from driver 515.43.04+
      # Currently alpha-quality/buggy, so false is currently the recommended setting.
      open = false;

      prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
        offload.enable = true;
        offload.enableOffloadCmd = true;
        # Make the Intel iGP default. The NVIDIA Quadro is for CUDA/NVENC
        # reverseSync.enable = true;
        # sync.enable = true;
      };
      nvidiaSettings = true;
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];

}
