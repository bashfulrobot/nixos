{ user-settings, pkgs, config, lib, inputs, ... }:
let cfg = config.apps.firefox;

in {
  options = {
    apps.firefox.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the Firefox Browser.";
    };
  };

  config = lib.mkIf cfg.enable {

    environment = {
      sessionVariables = { MOZ_USE_XINPUT2 = "1"; };

      # systemPackages = with pkgs;
      #   [
      #     (pkgs.wrapFirefox
      #       (pkgs.firefox-unwrapped.override { pipewireSupport = true; }) { })
      #   ];

    };

    home-manager.users."${user-settings.user.username}" = {
      programs = {
        firefox = {
          enable = true;
          package = pkgs.wrapFirefox
            (pkgs.firefox-unwrapped.override { pipewireSupport = true; }) { };
          profiles = {
            dustin = {
              isDefault = true;
              search = {
                force = true;
                default = "Kagi";
                privateDefault = "DuckDuckGo";
                order = [ "Kagi" "DuckDuckGo" "Google" ];
                engines = {
                  "Kagi" = {
                    urls = [{
                      template = "https://kagi.com/search?q={searchTerms}";
                    }];
                    iconUpdateURL = "https://kagi.com/favicon.ico";
                  };
                  "Bing".metaData.hidden = true;
                };
              };
              extensions = with pkgs.nur.repos.rycee.firefox-addons; [
                # see: https://github.com/nix-community/nur-combined/blob/master/repos/rycee/pkgs/firefox-addons/generated-firefox-addons.nix
                # https-everywhere
                markdownload
                grammarly
                onepassword-password-manager
                darkreader
                link-cleaner
                privacy-badger
                tree-style-tab
                multi-account-containers
                ublock-origin
                sidebery
              ];
              settings = {

                "browser.startup.homepage" = "about:home";

                # Disable irritating first-run stuff
                "browser.disableResetPrompt" = true;
                "browser.download.panel.shown" = true;
                "browser.feeds.showFirstRunUI" = false;
                "browser.messaging-system.whatsNewPanel.enabled" = false;
                "browser.rights.3.shown" = true;
                "browser.shell.checkDefaultBrowser" = false;
                "browser.shell.defaultBrowserCheckCount" = 1;
                "browser.startup.homepage_override.mstone" = "ignore";
                "browser.uitour.enabled" = false;
                "startup.homepage_override_url" = "";
                "trailhead.firstrun.didSeeAboutWelcome" = true;
                "browser.bookmarks.restore_default_bookmarks" = false;
                "browser.bookmarks.addedImportButton" = true;

                # Don't ask for download dir
                "browser.download.useDownloadDir" = false;

                # Disable crappy home activity stream page
                "browser.newtabpage.activity-stream.feeds.topsites" = false;
                "browser.newtabpage.activity-stream.showSponsoredTopSites" =
                  false;
                "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" =
                  false;
                "browser.newtabpage.blocked" = lib.genAttrs [
                  # Youtube
                  "26UbzFJ7qT9/4DhodHKA1Q=="
                  # Facebook
                  "4gPpjkxgZzXPVtuEoAL9Ig=="
                  # Wikipedia
                  "eV8/WsSLxHadrTL1gAxhug=="
                  # Reddit
                  "gLv0ja2RYVgxKdp0I5qwvA=="
                  # Amazon
                  "K00ILysCaEq8+bEqV/3nuw=="
                  # Twitter
                  "T9nJot5PurhJSy8n038xGA=="
                ] (_: 1);

                # Disable some telemetry
                "app.shield.optoutstudies.enabled" = false;
                "browser.discovery.enabled" = false;
                "browser.newtabpage.activity-stream.feeds.telemetry" = false;
                "browser.newtabpage.activity-stream.telemetry" = false;
                "browser.ping-centre.telemetry" = false;
                "datareporting.healthreport.service.enabled" = false;
                "datareporting.healthreport.uploadEnabled" = false;
                "datareporting.policy.dataSubmissionEnabled" = false;
                "datareporting.sessions.current.clean" = true;
                "devtools.onboarding.telemetry.logged" = false;
                "toolkit.telemetry.archive.enabled" = false;
                "toolkit.telemetry.bhrPing.enabled" = false;
                "toolkit.telemetry.enabled" = false;
                "toolkit.telemetry.firstShutdownPing.enabled" = false;
                "toolkit.telemetry.hybridContent.enabled" = false;
                "toolkit.telemetry.newProfilePing.enabled" = false;
                "toolkit.telemetry.prompted" = 2;
                "toolkit.telemetry.rejected" = true;
                "toolkit.telemetry.reportingpolicy.firstRun" = false;
                "toolkit.telemetry.server" = "";
                "toolkit.telemetry.shutdownPingSender.enabled" = false;
                "toolkit.telemetry.unified" = false;
                "toolkit.telemetry.unifiedIsOptIn" = false;
                "toolkit.telemetry.updatePing.enabled" = false;

                # Disable fx accounts
                "identity.fxaccounts.enabled" = false;
                # Disable "save password" prompt
                "signon.rememberSignons" = false;
                # Harden
                "privacy.trackingprotection.enabled" = true;
                "dom.security.https_only_mode" = true;
                # Layout
                "browser.uiCustomization.state" = builtins.toJSON {
                  currentVersion = 20;
                  newElementCount = 5;
                  dirtyAreaCache = [
                    "nav-bar"
                    "PersonalToolbar"
                    "toolbar-menubar"
                    "TabsToolbar"
                    "widget-overflow-fixed-list"
                  ];
                  placements = {
                    PersonalToolbar = [ "personal-bookmarks" ];
                    TabsToolbar =
                      [ "tabbrowser-tabs" "new-tab-button" "alltabs-button" ];
                    nav-bar = [
                      "back-button"
                      "forward-button"
                      "stop-reload-button"
                      "urlbar-container"
                      "downloads-button"
                      "ublock0_raymondhill_net-browser-action"
                      "_testpilot-containers-browser-action"
                      "reset-pbm-toolbar-button"
                      "unified-extensions-button"
                    ];
                    toolbar-menubar = [ "menubar-items" ];
                    unified-extensions-area = [ ];
                    widget-overflow-fixed-list = [ ];
                  };
                  seen = [
                    "save-to-pocket-button"
                    "developer-button"
                    "ublock0_raymondhill_net-browser-action"
                    "_testpilot-containers-browser-action"
                  ];
                };

              };
              # userChrome = ''
              #   #sidebar-box[sidebarcommand="treestyletab_piro_sakura_ne_jp-sidebar-action"] #sidebar-header {
              #     display: none;
              #   }

              #   #sidebar-header{ display: none }

              #   #main-window[tabsintitlebar="true"]:not([extradragspace="true"]) #TabsToolbar > .toolbar-items {
              #     opacity: 0;
              #     pointer-events: none;
              #   }
              #   #main-window:not([tabsintitlebar="true"]) #TabsToolbar {
              #       visibility: collapse !important;
              #   }
              # '';
            };
          };
        };
      };
    };
  };
}
