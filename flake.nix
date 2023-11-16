{
  description = "NixOS Sway configuration for Dustin Krysak";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # currently used for FF extensions
    nur.url = "github:nix-community/NUR";

  };

  outputs =
    inputs@{ self, nixpkgs, nixvim, home-manager, nixos-hardware, nur, ... }:
    with inputs;
    let
      nixpkgsConfig = { overlays = [ ]; };
      secrets =
        builtins.fromJSON (builtins.readFile "${self}/secrets/secrets.json");
    in {

      nixosConfigurations = {

        # dustin-krysak = work laptop hostname
        dustin-krysak = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs secrets; };
          system = "x86_64-linux";
          modules = [
            ./hosts/dustin-krysak
            nur.nixosModules.nur
            nixos-hardware.nixosModules.lenovo-thinkpad-x13-yoga
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = { inherit secrets; };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.dustin = {
                imports =
                  [ ./home/dustin-krysak nixvim.homeManagerModules.nixvim ];
              };

              # Overlays
              nixpkgs.overlays = [ nur.overlay ];

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
            ./hosts/rembot
            nur.nixosModules.nur
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = { inherit secrets; };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.dustin = {
                imports =
                  [ ./home/rembot inputs.nixvim.homeManagerModules.nixvim ];
              };

              # Overlays
              nixpkgs.overlays = [ nur.overlay ];

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
            ./hosts/nixdo

          ];

        };

      };
    };
}
