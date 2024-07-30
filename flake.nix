{
  description = "NixOS configuration for Dustin Krysak";

  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    nixos-hardware = { url = "github:NixOS/nixos-hardware/master"; };
    nix-flatpak = { url = "github:gmodena/nix-flatpak"; };
    nvim = { url = "github:bashfulrobot/jvim"; };
    # hyprland = { url = "github:hyprwm/Hyprland"; };
    # gBar.url = "github:scorpion-26/gBar";
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

    # currently used for FF extensions
    # nur.url = "github:nix-community/NUR";

  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixos-hardware, nix-flatpak, nvim, stylix, ... }:
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
    in
    {
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
      };
    };
}
