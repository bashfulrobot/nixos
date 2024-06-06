{
  description = "NixOS configuration for Dustin Krysak";

  inputs = {

    avalanche = {
      url = "github:snowfallorg/avalanche";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    envycontrol.url = "github:bayasdev/envycontrol";

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    nvim.url = "github:bashfulrobot/jvim";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprswitch (for windows switching in Hyprland)
    hyprswitch = { url = "github:h3rmt/hyprswitch/release"; };

    # currently used for FF extensions
    nur.url = "github:nix-community/NUR";

    kolide-launcher = {
      url = "github:/kolide/nix-agent/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixos-hardware, envycontrol
    , nix-flatpak, nur, kolide-launcher, hyprswitch, avalanche, nvim, ... }:
    with inputs;
    let
      # nixpkgsConfig = { overlays = [ ]; };
      workstationOverlays =
        [ nur.overlay avalanche.overlays.default nvim.overlays.default ];
      secrets =
        builtins.fromJSON (builtins.readFile "${self}/secrets/secrets.json");
      username = if builtins.getEnv "SUDO_USER" != "" then
        builtins.getEnv "SUDO_USER"
      else
        builtins.getEnv "USER";
    in {

      nixosConfigurations = {

        # evo = new work laptop hostname
        evo = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs secrets; };
          system = "x86_64-linux";
          modules = [
            ./systems/evo
            nur.nixosModules.nur
            nix-flatpak.nixosModules.nix-flatpak
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = { inherit secrets; };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              # Overlays - specified in "workstationOverlays"
              nixpkgs.overlays = workstationOverlays;

              # Allow unfree packages
              nixpkgs.config.allowUnfree = true;
            }
          ];
        };

        # rembot = desktop hostname
        rembot = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs secrets; };
          system = "x86_64-linux";
          modules = [
            ./systems/rembot
            nur.nixosModules.nur
            nix-flatpak.nixosModules.nix-flatpak
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = { inherit secrets; };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              # Overlays - specified in "workstationOverlays"
              nixpkgs.overlays = workstationOverlays;

              # Allow unfree packages
              nixpkgs.config.allowUnfree = true;
            }
          ];
        };

        # nixdo = server hostname
        nixdo = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs secrets; };
          system = "x86_64-linux";
          modules = [
            ./systems/nixdo

          ];

        };

      };

    };
}
