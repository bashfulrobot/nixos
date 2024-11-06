{
  description = "NixOS configuration for Dustin Krysak";

  inputs = {

    nixpkgs = { url = "github:nixos/nixpkgs/nixos-24.05"; };

    nixpkgs-unstable = { url = "github:nixos/nixpkgs/nixos-unstable"; };

    # nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };

    nixos-hardware = { url = "github:NixOS/nixos-hardware/master"; };

    nix-flatpak = { url = "github:gmodena/nix-flatpak"; };

    nvim = { url = "github:bashfulrobot/jvim"; };

    hyprland = { url = "git+https://github.com/hyprwm/Hyprland?submodules=1"; };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    hyprswitch.url = "github:h3rmt/hyprswitch/release?tag=v2.1.4";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    # Pin zoom at a working verison
    nixpkgs-zoom.url =
      "github:NixOS/nixpkgs/06031e8a5d9d5293c725a50acf01242193635022";

    # currently used for FF extensions
    nur.url = "github:nix-community/NUR";

  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager
    , plasma-manager, nix-flatpak
    , nur, nvim, disko, nixvim, ... }:
    # with inputs;
    let

      # add unstable to overlays
      # This allows me to use unstable packages in my system
      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit (final) system;
          config.allowUnfree = true;
          config.nvidia.acceptLicense = true;
        };
      };

      # Add overlays here, then pass the "workstationOverlays" reference into machine config.
      workstationOverlays =
        [ nur.overlay nvim.overlays.default overlay-unstable ];

      # Load secrets. This folder is encryted with git-crypt
      secrets =
        builtins.fromJSON (builtins.readFile "${self}/secrets/secrets.json");

      # Load user settings
      user-settings =
        builtins.fromJSON (builtins.readFile "${self}/settings/settings.json");

    in {
      nixosConfigurations = {

        # evo = new work laptop hostname
        evo = nixpkgs.lib.nixosSystem {

          specialArgs = {
            inherit user-settings inputs secrets nixpkgs-unstable;
          };

          system = "x86_64-linux";

          modules = [
            ./systems/evo
            nur.nixosModules.nur
            nix-flatpak.nixosModules.nix-flatpak
            home-manager.nixosModules.home-manager
            ## stylix.nixosModules.stylix
            disko.nixosModules.disko
            nixvim.nixosModules.nixvim

            {
              home-manager = {
                useUserPackages = true;
                sharedModules =
                  [ plasma-manager.homeManagerModules.plasma-manager ];
                useGlobalPkgs = true;
                extraSpecialArgs = { inherit user-settings secrets inputs; };
                users."${user-settings.user.username}" = { imports = [ ]; };
              };

              nixpkgs = {
                # Overlays - specified in "workstationOverlays"
                overlays = workstationOverlays;
                # Allow unfree packages
                config.allowUnfree = true;
              };

            }
          ];
        };

        # rembot = desktop hostname
        rembot = nixpkgs.lib.nixosSystem {

          specialArgs = {
            inherit user-settings inputs secrets nixpkgs-unstable;
          };

          system = "x86_64-linux";

          modules = [
            ./systems/rembot
            nur.nixosModules.nur
            nix-flatpak.nixosModules.nix-flatpak
            home-manager.nixosModules.home-manager
            # stylix.nixosModules.stylix
            nixvim.nixosModules.nixvim
            #  disko.nixosModules.disko - not in use yet, next reload

            {
              home-manager = {
                useUserPackages = true;
                sharedModules =
                  [ plasma-manager.homeManagerModules.plasma-manager ];
                useGlobalPkgs = true;
                extraSpecialArgs = { inherit user-settings secrets; };
                users."${user-settings.user.username}" = { imports = [ ]; };
              };

              nixpkgs = {
                # Overlays - specified in "workstationOverlays"
                overlays = workstationOverlays;
                # Allow unfree packages
                config.allowUnfree = true;
              };

            }
          ];
        };

        # nixdo = server hostname
        nixdo = nixpkgs.lib.nixosSystem {

          specialArgs = {
            inherit user-settings inputs secrets nixpkgs-unstable;
          };

          system = "x86_64-linux";

          modules = [ ./systems/nixdo ];
        };

        # srv = new work laptop hostname
        srv = nixpkgs.lib.nixosSystem {

          specialArgs = {
            inherit user-settings inputs secrets nixpkgs-unstable;
          };

          system = "x86_64-linux";

          modules = [
            ./systems/srv
            home-manager.nixosModules.home-manager
            nixvim.nixosModules.nixvim
            # Below not used, but autoimport fails without this
            nix-flatpak.nixosModules.nix-flatpak
            # nur.nixosModules.nur
            nix-flatpak.nixosModules.nix-flatpak
            # catppuccin.nixosModules.catppuccin
            home-manager.nixosModules.home-manager
            # stylix.nixosModules.stylix

            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                users."${user-settings.user.username}" = { imports = [ ]; };

                extraSpecialArgs = {
                  inherit user-settings secrets nixpkgs-unstable;
                };

              };

              nixpkgs = {
                # Allow unfree packages
                config.allowUnfree = true;
              };

            }
          ];
        };
      };
    };
}
