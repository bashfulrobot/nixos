{ config, ... }: {
  home.file.".config/mimeapps.list".text = ''

    [Default Applications]
    text/html=chromium-browser.desktop
    x-scheme-handler/http=chromium-browser.desktop
    x-scheme-handler/https=chromium-browser.desktop
    x-scheme-handler/about=chromium-browser.desktop
    x-scheme-handler/unknown=chromium-browser.desktop

    [Default Applications]
    x-scheme-handler/http=chromium-browser.desktop
    x-scheme-handler/https=chromium-browser.desktop
    text/html=chromium-browser.desktop
    application/xhtml+xml=chromium-browser.desktop
    x-scheme-handler/about=chromium-browser.desktop
    x-scheme-handler/unknown=chromium-browser.desktop
    x-scheme-handler/webcal=chromium-browser.desktop
    text/markdown=code.desktop
    x-scheme-handler/tootle=com.github.bleakgrey.tootle.desktop
    application/x-yaml=code.desktop
    x-scheme-handler/mailto=chromium-browser.desktop
    text/plain=code.desktop
    text/x-yaml=code.desktop
    application/x-shellscript=code.desktop
    x-scheme-handler/chrome=brave-browser.desktop
    application/x-extension-htm=chromium-browser.desktop
    application/x-extension-html=chromium-browser.desktop
    application/x-extension-shtml=chromium-browser.desktop
    application/x-extension-xhtml=chromium-browser.desktop
    application/x-extension-xht=chromium-browser.desktop
    application/pdf=org.gnome.Evince.desktop

    [Added Associations]
  '';
}
