{ config, inputs, pkgs, ... }: {

  imports =
    [ ./1password ./bluetooth ./dconf ./insecure-packages ./nix-settings ./pkgs ./sway ./syncthing/dustin-krysak.nix ./virtualization ];


}
