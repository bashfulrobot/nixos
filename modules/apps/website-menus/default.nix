{ user-settings, lib, inputs, pkgs, config, ... }:
let cfg = config.apps.website-menus;
urls = [
    { url = "https://example.com"; icon = "/path/to/icon1.png"; }
    { url = "https://anotherexample.com"; icon = "/path/to/icon2.png"; }
  ];

in {
  options = {
    apps.website-menus.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Add websites to my launcher menu.";
    };

  };

  config = lib.mkIf cfg.enable {

    # use regular package
    environment.systemPackages = with pkgs; [ google-chrome ];

    # home-manager.users."${user-settings.user.username}" = {

    # };
  };
}
