{
  description = "NixOS configuration for Dustin Krysak";

  inputs = {

    # Pin zoom at a working verison
    nixpkgs-zoom.url =
      "github:NixOS/nixpkgs/06031e8a5d9d5293c725a50acf01242193635022";

    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    nixos-hardware = { url = "github:NixOS/nixos-hardware/master"; };
    nix-flatpak = { url = "github:gmodena/nix-flatpak"; };
    nvim = { url = "github:bashfulrobot/jvim"; };
    nvchad4nix = {
      url = "github:NvChad/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin = { url = "github:catppuccin/nix"; };
    hyprswitch = { url = "github:h3rmt/hyprswitch/release"; };
    hyprland = { url = "github:hyprwm/Hyprland"; };
    gBar.url = "github:scorpion-26/gBar";
    zen-browser.url = "github:heywoodlh/flakes/main?dir=zen-browser";
    # This allows automatic styling based on active Wallpaper.
    # Homepage: https://github.com/danth/stylix
    # Manual:   https://danth.github.io/stylix
    stylix.url = "github:danth/stylix";
    # Use dev branch
    # hyprland = { url = "git+https://github.com/hyprwm/Hyprland?submodules=1"; };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # currently used for FF extensions
    nur.url = "github:nix-community/NUR";

  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixos-hardware, hyprswitch
    , hyprland, nix-flatpak, nur, nvim, catppuccin, stylix, disko, nvchad4nix
    , nixpkgs-zoom, nixvim, zen-browser, ... }:
    # with inputs;
    let
      # Add overlays here, then pass the "workstationOverlays" reference into machine config.
      workstationOverlays = [ nur.overlay nvim.overlays.default ];
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
          specialArgs = { inherit user-settings inputs secrets; };
          system = "x86_64-linux";
          modules = [
            ./systems/evo
            nur.nixosModules.nur
            nix-flatpak.nixosModules.nix-flatpak
            catppuccin.nixosModules.catppuccin
            home-manager.nixosModules.home-manager
            stylix.nixosModules.stylix
            disko.nixosModules.disko
            nixvim.nixosModules.nixvim
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                extraSpecialArgs = { inherit user-settings secrets; };
                users."${user-settings.user.username}" = {
                  imports = [ catppuccin.homeManagerModules.catppuccin ];
                };
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
          specialArgs = { inherit user-settings inputs secrets; };
          system = "x86_64-linux";
          modules = [
            ./systems/rembot
            nur.nixosModules.nur
            nix-flatpak.nixosModules.nix-flatpak
            catppuccin.nixosModules.catppuccin
            home-manager.nixosModules.home-manager
            stylix.nixosModules.stylix
            nixvim.nixosModules.nixvim
            #  disko.nixosModules.disko - not in use yet, next reload
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                extraSpecialArgs = { inherit user-settings secrets; };
                users."${user-settings.user.username}" = {
                  imports = [ catppuccin.homeManagerModules.catppuccin ];
                };
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
          specialArgs = { inherit user-settings inputs secrets; };
          system = "x86_64-linux";
          modules = [ ./systems/nixdo ];
        };

        # srv = new work laptop hostname
        srv = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit user-settings inputs secrets; };
          system = "x86_64-linux";
          modules = [
            ./systems/srv
            home-manager.nixosModules.home-manager
            nixvim.nixosModules.nixvim
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                extraSpecialArgs = { inherit user-settings secrets; };
                users."${user-settings.user.username}" = {
                  imports = [];
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
