{ inputs, ... }:

{
  imports = [
    # inputs.disko.nixosModules.disko
    # (import ./disks.nix { })
     # in hw
    ./fingerprint.nix
     # in hw
    ./wifi.nix
    ./nvidia.nix
    # in hw
    inputs.nixos-hardware.nixosModules.common-cpu-intel

    inputs.nixos-hardware.nixosModules.common-gpu-nvidia
    inputs.nixos-hardware.nixosModules.common-gpu-intel
    inputs.nixos-hardware.nixosModules.common-hidpi
    inputs.nixos-hardware.nixosModules.common-pc
     # in hw
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
     # in hw
    inputs.nixos-hardware.nixosModules.common-pc-laptop

  ];

}
