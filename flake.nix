{
  description = "NixOS configuration for Dustin Krysak";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    envycontrol.url = "github:bayasdev/envycontrol";

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # currently used for FF extensions
    nur.url = "github:nix-community/NUR";

    kolide-launcher = {
      url = "github:/kolide/nix-agent/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixos-hardware, envycontrol
    , nix-flatpak, nur, kolide-launcher, ... }:
    with inputs;
    let
      nixpkgsConfig = { overlays = [ ]; };
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
          # format different due to kolide-launcher
          # nixpkgs.config.allowUnfree = true; only applies to non-flakes.
          specialArgs = {
            inherit inputs secrets;
            pkgs = import nixpkgs {
              system = "x86_64-linux";
              config.allowUnfree = true;
            };
          };
          system = "x86_64-linux";
          modules = [
            ./systems/evo
            nur.nixosModules.nur
            # nixos-hardware.nixosModules.lenovo-thinkpad-x13-yoga
            home-manager.nixosModules.home-manager
            nix-flatpak.nixosModules.nix-flatpak
            kolide-launcher.nixosModules.kolide-launcher
            {
              home-manager.extraSpecialArgs = { inherit secrets; };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users."${username}" = {
                # imports = [ ./home/evo ];
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
            ./systems/rembot
            nur.nixosModules.nur
            nix-flatpak.nixosModules.nix-flatpak
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = { inherit secrets; };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users."${username}" = {
                # imports = [ ./home/rembot ];
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
            ./systems/nixdo

          ];

        };

      };
    };
}
