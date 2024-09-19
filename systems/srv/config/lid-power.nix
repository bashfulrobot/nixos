{ config, pkgs, ... }: {
  # Prevent the laptop from going to sleep when the lid closes
  # Only works if use is logged in
  services.logind.lidSwitchExternalPower = "ignore";

  # below seems to do the job for the lid
  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernation=no
    AllowHybridSleep=no
    AllowSuspendThenHibernate=no
  '';
}
