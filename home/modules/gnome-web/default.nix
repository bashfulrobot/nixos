{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {

    "org/gnome/epiphany/web" = {
      enable-webextensions = true;
      ask-on-download = true;
    };
    "org/gnome/epiphany" = {
      default-search-engine = "kagi";
      homepage-url = "https://kagi.com/";
      search-engine-providers =
        "[{'url': <'https://kagi.com/search?token=BAIACfLCfAU.NPI9eY4Bm0jNeuQ84acckiihRS4MkM0VZAQus77jG3o&q=%s'>, 'bang': <'!k'>, 'name': <'kagi'>}, {'url': <'https://duckduckgo.com/?q=%s&t=epiphany'>, 'bang': <'!ddg'>, 'name': <'DuckDuckGo'>}]";
    };
  };
}
