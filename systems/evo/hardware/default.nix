{ inputs, lib, ... }:

{
  imports = [
    ./boot.nix
    ./disko.nix
    ./gpus.nix
    ./hardware-configuration.nix
    # ./kernel.nix
    # inputs.nixos-hardware.nixosModules.common-cpu-intel
    # inputs.nixos-hardware.nixosModules.common-hidpi
    # inputs.nixos-hardware.nixosModules.common-pc
    # inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
    # inputs.nixos-hardware.nixosModules.common-pc-laptop

    ### Nvidia GPU
    # I pulled the config from here, and the wiki, and made my specific changes
    # inputs.nixos-hardware.nixosModules.common-gpu-nvidia

  ];

  # TODO: testing removal due to error
  # services = {
  #   kmscon = {
  #     enable = true;
  #     extraConfig = lib.mkForce ''
  #     font-size=24
  #     xkb-layout=us
  #   '';
  #   };
  # };

}
