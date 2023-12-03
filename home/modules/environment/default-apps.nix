{ config, ... }: {
  home.file.".config/mimeapps.list".text = ''
    [Default Applications]
    x-scheme-handler/http=firefox.desktop
    x-scheme-handler/https=firefox.desktop
    text/html=firefox.desktop
    application/xhtml+xml=firefox.desktop
    x-scheme-handler/mailspring=Mailspring.desktop
    x-scheme-handler/about=firefox.desktop
    x-scheme-handler/unknown=firefox.desktop
    x-scheme-handler/webcal=firefox.desktop
    text/markdown=code.desktop
    x-scheme-handler/tootle=com.github.bleakgrey.tootle.desktop
    application/x-yaml=code.desktop
    x-scheme-handler/mailto=firefox.desktop
    text/plain=code.desktop
    text/x-yaml=code.desktop
    application/x-shellscript=code.desktop
    x-scheme-handler/chrome=firefox.desktop
    application/x-extension-htm=firefox.desktop
    application/x-extension-html=firefox.desktop
    application/x-extension-shtml=firefox.desktop
    application/x-extension-xhtml=firefox.desktop
    application/x-extension-xht=firefox.desktop
    application/pdf=org.gnome.Evince.desktop

    [Added Associations]
    application/xhtml+xml=firefox.desktop;firefox.desktop;
    text/markdown=code.desktop;
    application/x-yaml=code.desktop;
    text/plain=code.desktop;
    application/x-shellscript=code.desktop;
    x-scheme-handler/chrome=firefox.desktop;
    application/x-extension-htm=firefox.desktop;
    application/x-extension-html=firefox.desktop;
    application/x-extension-shtml=firefox.desktop;
    application/x-extension-xhtml=firefox.desktop;
    application/x-extension-xht=firefox.desktop;
  '';
}
