{ pkgs, lib, config, ... }:
let cfg = config.hw.fprintd;
in {
  options = {
    hw.fprintd.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable fingerprint reader.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [

    ];

    systemd.services.fprintd = {
      wantedBy = [ "multi-user.target" ];
      serviceConfig.Type = "simple";
    };

    services.fprintd = {
      enable = true;
      tod = {
        enable = true;
        driver = pkgs.libfprint-2-tod1-goodix;
      };

    };

    # Used to allow a password login on first login as an alternative to just a fingerprint. As described here: https://github.com/NixOS/nixpkgs/issues/171136
    security.pam.services.login.fprintAuth = false;
    # similarly to how other distributions handle the fingerprinting login
    security.pam.services.gdm-fingerprint =
      lib.mkIf (config.services.fprintd.enable) {
        text = ''
          auth       required                    pam_shells.so
          auth       requisite                   pam_nologin.so
          auth       requisite                   pam_faillock.so      preauth
          auth       required                    ${pkgs.fprintd}/lib/security/pam_fprintd.so
          auth       optional                    pam_permit.so
          auth       required                    pam_env.so
          auth       [success=ok default=1]      ${pkgs.gdm}/lib/security/pam_gdm.so
          auth       optional                    ${pkgs.gnome-keyring}/lib/security/pam_gnome_keyring.so

          account    include                     login

          password   required                    pam_deny.so

          session    include                     login
          session    optional                    ${pkgs.gnome-keyring}/lib/security/pam_gnome_keyring.so auto_start
        '';
      };
  };
}
