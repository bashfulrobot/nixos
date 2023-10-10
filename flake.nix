{
  description = "NixOS Sway configuration for Dustin Krysak";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # currently used for FF extensions
    nur.url = "github:nix-community/NUR";

    # Themes
    nix-colors.url = "github:misterio77/nix-colors";

  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixos-hardware, nur
    , nix-colors, ... }:
    let nixpkgsConfig = { overlays = [ ]; };
    in {

      nixosConfigurations = {

        # dustin-krysak = work laptop hostname
        dustin-krysak = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          system = "x86_64-linux";
          modules = [
            ./hosts/dustin-krysak
            nur.nixosModules.nur
            nix-colors.homeManagerModules.default
            nixos-hardware.nixosModules.lenovo-thinkpad-x13-yoga
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.dustin = {
                imports = [ ./home/dustin-krysak ];
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
          specialArgs = { inherit inputs; };
          system = "x86_64-linux";
          modules = [
            ./hosts/rembot
            nur.nixosModules.nur
            nix-colors.homeManagerModules.default
            nixos-hardware.nixosModules.lenovo-thinkpad-x13-yoga
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.dustin = { imports = [ ./home/rembot ]; };

              # Overlays
              nixpkgs.overlays = [ nur.overlay ];

              # Allow unfree packages
              nixpkgs.config.allowUnfree = true;
            }
          ];
        };

        # nixdo = server hostname
        nixdo = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          system = "x86_64-linux";
          modules = [ ./hosts/nixdo ];
        };

      };
    };
}
