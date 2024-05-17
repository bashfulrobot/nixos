{ pkgs, config, libs, inputs, ... }: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia
    inputs.nixos-hardware.nixosModules.common-gpu-intel
  ];

  boot = {
    blacklistedKernelModules = lib.mkDefault [ "nouveau" ];
    kernelModules = [ "kvm-intel" "nvidia" ];
  };

  hardware = {
    nvidia = {
      prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
        # Make the Intel iGP default. The NVIDIA Quadro is for CUDA/NVENC
        reverseSync.enable = true;
      };
      nvidiaSettings = true;
    };
  };

}
