{ config, ... }: {
  home.file.".config/mimeapps.list".text = ''
    [Default Applications]
    x-scheme-handler/http=microsoft-edge.desktop
    x-scheme-handler/https=microsoft-edge.desktop
    text/html=microsoft-edge.desktop
    application/xhtml+xml=microsoft-edge.desktop
    x-scheme-handler/mailspring=Mailspring.desktop
    x-scheme-handler/about=microsoft-edge.desktop
    x-scheme-handler/unknown=microsoft-edge.desktop
    x-scheme-handler/webcal=microsoft-edge.desktop
    text/markdown=code.desktop
    x-scheme-handler/tootle=com.github.bleakgrey.tootle.desktop
    application/x-yaml=code.desktop
    x-scheme-handler/mailto=microsoft-edge.desktop
    text/plain=code.desktop
    text/x-yaml=code.desktop
    application/x-shellscript=code.desktop
    x-scheme-handler/chrome=microsoft-edge.desktop
    application/x-extension-htm=microsoft-edge.desktop
    application/x-extension-html=microsoft-edge.desktop
    application/x-extension-shtml=microsoft-edge.desktop
    application/x-extension-xhtml=microsoft-edge.desktop
    application/x-extension-xht=microsoft-edge.desktop
    application/pdf=org.gnome.Evince.desktop

    [Added Associations]
    application/xhtml+xml=microsoft-edge.desktop;microsoft-edge.desktop;
    text/markdown=code.desktop;
    application/x-yaml=code.desktop;
    text/plain=code.desktop;
    application/x-shellscript=code.desktop;
    x-scheme-handler/chrome=microsoft-edge.desktop;
    application/x-extension-htm=microsoft-edge.desktop;
    application/x-extension-html=microsoft-edge.desktop;
    application/x-extension-shtml=microsoft-edge.desktop;
    application/x-extension-xhtml=microsoft-edge.desktop;
    application/x-extension-xht=microsoft-edge.desktop;
  '';
}
