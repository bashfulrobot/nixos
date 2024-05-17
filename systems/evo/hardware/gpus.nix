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
