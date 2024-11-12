{ user-settings, config, lib, secrets, pkgs, inputs, ... }:

let
  cfg = config.apps.one-password;
  onePassPath = "~/.1password/agent.sock";

in {

  options = {
    apps.one-password.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable one-password.";
    };
  };

  config = lib.mkIf cfg.enable {

    # The 1Password app can unlock your browser extension using a special native messaging process. This streamlines your 1Password experience: Once you unlock 1Password from your tray icon, your browser extensions will be unlocked as well.
    environment.etc = {
      "1password/custom_allowed_browsers" = {
        text = ''
          vivaldi-bin
          brave
          chromium
          .zen-wrapped
        '';
        mode = "0755";
      };
    };

    # Enable the 1Passsword GUI with myself as an authorized user for polkit
    programs = {
      _1password = {
        enable = true;
        package = pkgs.unstable._1password-cli;
      };
      _1password-gui = {
        enable = true;
        package = pkgs.unstable._1password-gui;
        # polkitPolicyOwners = [ "${user-settings.user.username}" ];
        polkitPolicyOwners = [ "dustin" ];
        # polkitPolicyOwners = config.users.groups.wheel.members;
      };

    };

    # used in Gnome
    home-manager.users."${user-settings.user.username}" = {
      home.file."1password.desktop" = {
        source = ./1password.desktop;
        target = ".config/autostart/1password.desktop";
      };

      # SSH configuration to use 1Password SSH agent
      # TODO: TEST this
      # programs.ssh = {
      #   enable = true;
      #   extraConfig = ''
      #     Host *
      #         IdentityAgent ${onePassPath}
      #   '';
      # };

      # You can enable Git's SSH singing with Home Manager:
      # TODO: TEST this
      #     git = {
      #   enable = true;
      #   extraConfig = {
      #     gpg = {
      #       format = "ssh";
      #     };
      #     "gpg \"ssh\"" = {
      #       program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
      #     };
      #     commit = {
      #       gpgsign = true;
      #     };

      #     user = {
      #       signingKey = "...";
      #     };
      #   };
      # };
    };
  };
}
