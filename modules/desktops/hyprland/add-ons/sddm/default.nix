# https://wiki.archlinux.org/title/SDDM
{ user-settings, pkgs, config, lib, inputs, system, ... }:
with lib;
let cfg = config.desktops.hyprland.add-ons.sddm;
in {
  options.desktops.hyprland.add-ons.sddm.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable sddm for hyprland";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [
        (elegant-sddm.override {
          themeConfig.General = {
            background = toString ./skullskates.png;
            backgroundMode = "fill";
            # FacesDir = toString ./;
            CursorTheme = "Bibata-Modern-Classic";
            CursorSize = "24";
            Font = "Work Sans 20,-1,5,50,0,0,0,0,0";
          };
        })
      ];
    services = {
      displayManager = {

        defaultSession = "hyprland";

        sddm = {
          wayland.enable = true;
          enable = true;
          theme = "Elegant";
        }; # end sddm

      }; # end displayManager

      gnome = {
        # TODO: move to another module - does not belong here
        evolution-data-server.enable = true;
        gnome-online-accounts.enable = true;
        # Enable the gnome-keyring secrets vault.
        # Will be exposed through DBus to programs willing to store secrets
        gnome-keyring.enable = true;
      };

      # TODO: move to another module - does not belong here
      gvfs.enable = true;
      # TODO: move to another module - does not belong here
      accounts-daemon.enable = true;

    };

    security = {

      polkit.enable = true;

      pam = {
        services = {
          # keyring does not start otherwise - enable once I go to lightdm
          sddm = {
            enableGnomeKeyring = true;
            # enableKwallet = true;
          };
          # login = {
          #   enableKwallet = true;
          # };
        };
      };
    };

    # Define systemd service to run on boot to load avatars for sddm
    systemd.services."sddm-avatar" = {
      description = "Service to copy or update users Avatars at startup.";
      wantedBy = [ "multi-user.target" ];
      before = [ "sddm.service" ];
      script = ''
        set -eu
        for user in /home/*; do
            username=$(basename "$user")
            if [ -f "$user/.face.icon" ]; then
                if [ ! -f "/var/lib/AccountsService/icons/$username" ]; then
                    cp "$user/.face.icon" "/var/lib/AccountsService/icons/$username"
                else
                    if [ "$user/.face.icon" -nt "/var/lib/AccountsService/icons/$username" ]; then
                        cp "$user/.face.icon" "/var/lib/AccountsService/icons/$username"
                    fi
                fi
            fi
        done
      '';
      serviceConfig = {
        Type = "simple";
        User = "root";
        StandardOutput = "journal+console";
        StandardError = "journal+console";
      };
    };

    # # Ensures SDDM starts after the service.
    systemd.services.sddm = { after = [ "sddm-avatar.service" ]; };

    home-manager.users.${user-settings.user.username} = {

      services = {
        gnome-keyring = {
          enable = true;
          components = [ "pkcs11" "secrets" "ssh" ];
          # components = [ "pkcs11" "secrets" ];
        };

      };

      home.file = { ".face.icon".source = ./.face.icon; };
    };
  };
}
