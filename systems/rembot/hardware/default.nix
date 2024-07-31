{ inputs, ... }:

{
  imports = [

    ./boot.nix
    # ./disko.nix
    ./gpus.nix
    ./hardware-configuration.nix
    ./kernel.nix
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-hidpi
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd

  ];

}
