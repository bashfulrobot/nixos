{ config, ... }: {
  home.file.".config/mimeapps.list".text = ''
    [Default Applications]
    x-scheme-handler/http=linkr.desktop
    x-scheme-handler/https=linkr.desktop
    text/html=linkr.desktop
    application/xhtml+xml=linkr.desktop
    x-scheme-handler/about=linkr.desktop
    x-scheme-handler/unknown=linkr.desktop
    x-scheme-handler/webcal=linkr.desktop
    text/markdown=code.desktop
    x-scheme-handler/tootle=com.github.bleakgrey.tootle.desktop
    application/x-yaml=code.desktop
    x-scheme-handler/mailto=linkr.desktop
    text/plain=code.desktop
    text/x-yaml=code.desktop
    application/x-shellscript=code.desktop
    x-scheme-handler/chrome=brave-browser.desktop
    application/x-extension-htm=linkr.desktop
    application/x-extension-html=linkr.desktop
    application/x-extension-shtml=linkr.desktop
    application/x-extension-xhtml=linkr.desktop
    application/x-extension-xht=linkr.desktop
    application/pdf=org.gnome.Evince.desktop

    [Added Associations]
  '';
}
