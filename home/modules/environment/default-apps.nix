{ config, ... }: {
  home.file.".config/mimeapps.list".text = ''
    [Default Applications]
    x-scheme-handler/http=chromium.desktop
    x-scheme-handler/https=chromium.desktop
    text/html=chromium.desktop
    application/xhtml+xml=chromium.desktop
    x-scheme-handler/about=chromium.desktop
    x-scheme-handler/unknown=chromium.desktop
    x-scheme-handler/webcal=chromium.desktop
    text/markdown=code.desktop
    x-scheme-handler/tootle=com.github.bleakgrey.tootle.desktop
    application/x-yaml=code.desktop
    x-scheme-handler/mailto=chromium.desktop
    text/plain=code.desktop
    text/x-yaml=code.desktop
    application/x-shellscript=code.desktop
    x-scheme-handler/chrome=chromium.desktop
    application/x-extension-htm=chromium.desktop
    application/x-extension-html=chromium.desktop
    application/x-extension-shtml=chromium.desktop
    application/x-extension-xhtml=chromium.desktop
    application/x-extension-xht=chromium.desktop
    application/pdf=org.gnome.Evince.desktop

    [Added Associations]
    application/xhtml+xml=chromium.desktop;chromium.desktop;
    text/markdown=code.desktop;
    application/x-yaml=code.desktop;
    text/plain=code.desktop;
    application/x-shellscript=code.desktop;
    x-scheme-handler/chrome=chromium.desktop;
    application/x-extension-htm=chromium.desktop;
    application/x-extension-html=chromium.desktop;
    application/x-extension-shtml=chromium.desktop;
    application/x-extension-xhtml=chromium.desktop;
    application/x-extension-xht=chromium.desktop;
  '';
}
