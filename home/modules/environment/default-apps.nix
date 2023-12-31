{ config, ... }: {
  home.file.".config/mimeapps.list".text = ''
    [Default Applications]
    x-scheme-handler/http=vivaldi.desktop
    x-scheme-handler/https=vivaldi.desktop
    text/html=vivaldi.desktop
    application/xhtml+xml=vivaldi.desktop
    x-scheme-handler/mailspring=Mailspring.desktop
    x-scheme-handler/about=vivaldi.desktop
    x-scheme-handler/unknown=vivaldi.desktop
    x-scheme-handler/webcal=vivaldi.desktop
    text/markdown=code.desktop
    x-scheme-handler/tootle=com.github.bleakgrey.tootle.desktop
    application/x-yaml=code.desktop
    x-scheme-handler/mailto=vivaldi.desktop
    text/plain=code.desktop
    text/x-yaml=code.desktop
    application/x-shellscript=code.desktop
    x-scheme-handler/chrome=vivaldi.desktop
    application/x-extension-htm=vivaldi.desktop
    application/x-extension-html=vivaldi.desktop
    application/x-extension-shtml=vivaldi.desktop
    application/x-extension-xhtml=vivaldi.desktop
    application/x-extension-xht=vivaldi.desktop
    application/pdf=org.gnome.Evince.desktop

    [Added Associations]
    application/xhtml+xml=vivaldi.desktop;vivaldi.desktop;
    text/markdown=code.desktop;
    application/x-yaml=code.desktop;
    text/plain=code.desktop;
    application/x-shellscript=code.desktop;
    x-scheme-handler/chrome=vivaldi.desktop;
    application/x-extension-htm=vivaldi.desktop;
    application/x-extension-html=vivaldi.desktop;
    application/x-extension-shtml=vivaldi.desktop;
    application/x-extension-xhtml=vivaldi.desktop;
    application/x-extension-xht=vivaldi.desktop;
  '';
}
