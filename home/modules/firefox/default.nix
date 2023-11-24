{ inputs, lib, config, pkgs, ... }: {

  programs.firefox = {
    enable = true;
    # package = pkgs.firefox-devedition;

    profiles = {
      default = {
        id = 0;
        name = "Default";
        isDefault = true;
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          # see: https://github.com/nix-community/nur-combined/blob/master/repos/rycee/pkgs/firefox-addons/generated-firefox-addons.nix
          # https-everywhere
          # languagetool
          onepassword-password-manager
          gnome-shell-integration
          darkreader
          grammarly
          ublock-origin
          dracula-dark-colorscheme
          markdownload
          privacy-badger
          multi-account-containers
          new-window-without-toolbar
          decentraleyes
          okta-browser-plugin
          theater-mode-for-youtube
          link-cleaner
          xbrowsersync
          redirector
          auto-tab-discard
          amp2html
        ];
        # bookmarks = {
        #   "📎 Add bookmark" = {
        #     url =
        #       "javascript: (function() {    var bookmarkUrl = window.location;    var applicationUrl = 'https://linkding.buffs.cc/bookmarks/new';    applicationUrl += '?url=' + encodeURIComponent(bookmarkUrl);    applicationUrl += '&auto_close';    window.open(applicationUrl);})();";
        #   };
        # };
      };

    };
  };

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    MOZ_USE_XINPUT2 = "1";
  };
}
