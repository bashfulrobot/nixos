{
  description = "NixOS configuration for Dustin Krysak";

  inputs = {

    # Pin zoom at a working verison
    nixpkgs-zoom.url =
      "github:NixOS/nixpkgs/06031e8a5d9d5293c725a50acf01242193635022";

    # nixpkgs = { url = "github:nixos/nixpkgs/nixos-24.05"; };
    # nixpkgs-unstable = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    nixos-hardware = { url = "github:NixOS/nixos-hardware/master"; };
    nix-flatpak = { url = "github:gmodena/nix-flatpak"; };
    nvim = { url = "github:bashfulrobot/jvim"; };
    hyprland = { url = "git+https://github.com/hyprwm/Hyprland?submodules=1"; };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hyprswitch.url = "github:h3rmt/hyprswitch/release?tag=v2.1.4";
    # hyprswitch.url = "github:h3rmt/hyprswitch/release";
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

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    # currently used for FF extensions
    nur.url = "github:nix-community/NUR";

  };

  outputs = inputs@{ self, nixpkgs, home-manager, plasma-manager, nixos-hardware
    , hyprland, hyprland-plugins, nix-flatpak, nur, nvim, stylix, disko
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
            home-manager.nixosModules.home-manager
            stylix.nixosModules.stylix
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
          specialArgs = { inherit user-settings inputs secrets; };
          system = "x86_64-linux";
          modules = [
            ./systems/rembot
            nur.nixosModules.nur
            nix-flatpak.nixosModules.nix-flatpak
            home-manager.nixosModules.home-manager
            stylix.nixosModules.stylix
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
            # Below not used, but autoimport fails without this
            nix-flatpak.nixosModules.nix-flatpak
            # nur.nixosModules.nur
            nix-flatpak.nixosModules.nix-flatpak
            # catppuccin.nixosModules.catppuccin
            home-manager.nixosModules.home-manager
            stylix.nixosModules.stylix
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                extraSpecialArgs = { inherit user-settings secrets; };
                users."${user-settings.user.username}" = { imports = [ ]; };
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
