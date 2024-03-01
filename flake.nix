{
  description = "NixOS Sway configuration for Dustin Krysak";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # currently used for FF extensions
    nur.url = "github:nix-community/NUR";

  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixos-hardware, nix-flatpak
    , nur, ... }:
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
            nix-flatpak.nixosModules.nix-flatpak
            {
              home-manager.extraSpecialArgs = { inherit secrets; };
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

        # evo = work laptop hostname
        evo = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs secrets; };
          system = "x86_64-linux";
          modules = [
            ./hosts/evo
            nur.nixosModules.nur
            # nixos-hardware.nixosModules.lenovo-thinkpad-x13-yoga
            home-manager.nixosModules.home-manager
            nix-flatpak.nixosModules.nix-flatpak
            {
              home-manager.extraSpecialArgs = { inherit secrets; };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.dustin = {
                imports = [ ./home/evo ];
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
            nix-flatpak.nixosModules.nix-flatpak
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = { inherit secrets; };
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
          specialArgs = { inherit inputs secrets; };
          system = "x86_64-linux";
          modules = [
            ./hosts/nixdo

          ];

        };

      };
    };
}
