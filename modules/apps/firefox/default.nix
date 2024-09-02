{ user-settings, pkgs, config, lib, inputs, ... }:
let
  cfg = config.apps.firefox;
  # firefoxGnomeTheme = pkgs.callPackage ./build { inherit user-settings; };
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

      # systemPackages = with pkgs; [ firefoxGnomeTheme ];

    };

    home-manager.users."${user-settings.user.username}" = {

      # home.packages = [ firefoxGnomeTheme ];

      # home.file.".mozilla/firefox/profiles/dustin/chrome".source = "${firefoxGnomeTheme}/chrome";

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
                multi-account-containers
                ublock-origin
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

                # ui changes
                # disable warning about about:config
                "browser.aboutConfig.showWarning" = false;
                # enable compact mode
                "browser.compactmode.show" = true;
                # enable dense UI
                "browser.uidensity" = 1;

                # let me close and open tabs without confirmation
                "browser.tabs.closeWindowWithLastTab" =
                  false; # don't close window when last tab is closed
                "browser.tabs.loadBookmarksInTabs" =
                  true; # open bookmarks in new tab
                "browser.tabs.loadDivertedInBackground" =
                  false; # open new tab in background
                "browser.tabs.loadInBackground" =
                  true; # open new tab in background
                "browser.tabs.warnOnClose" =
                  false; # don't warn when closing multiple tabs
                "browser.tabs.warnOnCloseOtherTabs" =
                  false; # don't warn when closing multiple tabs
                "browser.tabs.warnOnOpen" =
                  false; # don't warn when opening multiple tabs
                "browser.tabs.warnOnQuit" =
                  false; # don't warn when closing multiple tabs

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

                "toolkit.legacyUserProfileCustomizations.stylesheets" =
                  true; # enable userChrome.css
                "browser.tabs.tabmanager.enabled" =
                  false; # hide tab search button

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

              userChrome = ''
                /*
                How To:
                1. Find your firefox profile folder : https://support.mozilla.org/en-US/kb/profiles-where-firefox-stores-user-data
                2. create a "chrome" folder if it doesn't exist
                3. Paste content of this gist in a "userChrome.css" file
                4. Go to about:config and set toolkit.legacyUserProfileCustomizations.stylesheets to true
                5. set browser.tabs.tabmanager.enabled to false (to hide the "tab search" button)
                5. Restart Firefox
                Don't hesitate to say if there are bugs, I only tested this for my workflow : I don't use tabs
                at all but I want to see the bar if I open a tab by mistake (otherwise I sometimes lose a tab)
                */

                /* Copy the default settings for --tab-min-height as --hidetabs-tab-min-height */
                :root {
                    --hidetabs-tab-min-height: 33px;
                }

                :root[uidensity=compact] {
                    --hidetabs-tab-min-height: 29px;
                }

                :root[uidensity=touch] {
                    --hidetabs-tab-min-height: 41px;
                }

                /* Set --tab-min-height to 0px so tab bar can disappear */
                #tabbrowser-tabs {
                    --tab-min-height: 0px;
                }

                /* Restore minimum height when more than one tab */
                #tabbrowser-tabs tab {
                    min-height: var(--hidetabs-tab-min-height);
                }

                /* Collapse tab bar when there is only one tab (tab is both first & last) */
                #tabbrowser-tabs tab[first-visible-tab="true"][last-visible-tab="true"] {
                    visibility: collapse;
                }

                /* Hide the New Tab button when there is only one tab (first visible tab is
                   adjacent to new tab button) */
                #tabbrowser-tabs tab[first-visible-tab="true"] + #tabs-newtab-button {
                    vis
              '';
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
