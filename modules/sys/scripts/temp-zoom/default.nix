{ user-settings, pkgs, lib, config, ... }:

let
  cfg = config.sys.scripts.run-zoom;
  runZoom = pkgs.writeShellApplication {
    name = "run-zoom";

    # runtimeInputs = [ pkgs.restic pkgs.pass ];

    text = ''
      #!/run/current-system/sw/bin/env bash

      export NIXPKGS_ALLOW_UNFREE=1
      nix run nixpkgs#zoom-us --impure

      exit 0
    '';
  };
in {
  options = {
    sys.scripts.run-zoom.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the run-zoom script.";
    };
  };
  config = lib.mkIf cfg.enable {
      environment.systemPackages = [ runZoom ];
    # home-manager.users."${user-settings.user.username}" = {

    # };
  };

}
