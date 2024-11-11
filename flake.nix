{
  description = "NixOS configuration for Dustin Krysak";

  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-24.05"; };
    nixpkgs-unstable = { url = "github:nixos/nixpkgs/nixos-unstable"; };
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
    nixpkgs-zoom.url =
      "github:NixOS/nixpkgs/06031e8a5d9d5293c725a50acf01242193635022";
    nur.url = "github:nix-community/NUR";
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager
    , plasma-manager, nix-flatpak, nur, nvim, disko, nixvim, catppuccin, ... }:
    let
      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit (final) system;
          config.allowUnfree = true;
          config.nvidia.acceptLicense = true;
        };
      };

      workstationOverlays =
        [ nur.overlay nvim.overlays.default overlay-unstable ];

      secrets =
        builtins.fromJSON (builtins.readFile "${self}/secrets/secrets.json");

      user-settings =
        builtins.fromJSON (builtins.readFile "${self}/settings/settings.json");

      commonModules = [
        nur.nixosModules.nur
        nix-flatpak.nixosModules.nix-flatpak
        home-manager.nixosModules.home-manager
        catppuccin.nixosModules.catppuccin
        nixvim.nixosModules.nixvim
        disko.nixosModules.disko
      ];

      serverModules =
        [ home-manager.nixosModules.home-manager nixvim.nixosModules.nixvim disko.nixosModules.disko ];

      commonHomeManagerConfig = {
        home-manager = {
          useUserPackages = true;
          sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];
          useGlobalPkgs = true;
          extraSpecialArgs = { inherit user-settings secrets inputs; };
          users."${user-settings.user.username}" = {
            imports = [ catppuccin.homeManagerModules.catppuccin ];
          };
        };
      };

      serverHomeManagerConfig = {
        home-manager = {
          useUserPackages = true;
          sharedModules = [ ];
          useGlobalPkgs = true;
          extraSpecialArgs = { inherit user-settings secrets inputs; };
          users."${user-settings.user.username}" = { imports = [ ]; };
        };
      };

      commonNixpkgsConfig = {
        nixpkgs = {
          overlays = workstationOverlays;
          config.allowUnfree = true;
        };
      };

      makeSystem = name: modules:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit user-settings inputs secrets nixpkgs-unstable;
          };
          system = "x86_64-linux";
          modules = modules;
        };

    in {
      nixosConfigurations = {
        evo = makeSystem "evo" (commonModules
          ++ [ ./systems/evo commonHomeManagerConfig commonNixpkgsConfig ]);
        rembot = makeSystem "rembot" (commonModules
          ++ [ ./systems/rembot commonHomeManagerConfig commonNixpkgsConfig ]);
        nixdo = makeSystem "nixdo" [ ./systems/nixdo ];
        srv = makeSystem "srv" (serverModules
          ++ [ ./systems/srv serverHomeManagerConfig commonNixpkgsConfig ]);
      };
    };
}
