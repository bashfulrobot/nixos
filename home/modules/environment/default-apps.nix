{ config, ... }: {
  home.file.".config/mimeapps.list".text = ''
    [Default Applications]
    x-scheme-handler/http=re.sonny.Junction.desktop
    x-scheme-handler/https=re.sonny.Junction.desktop
    text/html=re.sonny.Junction.desktop
    application/xhtml+xml=re.sonny.Junction.desktop
    x-scheme-handler/about=re.sonny.Junction.desktop
    x-scheme-handler/unknown=re.sonny.Junction.desktop
    x-scheme-handler/webcal=re.sonny.Junction.desktop
    text/markdown=code.desktop
    x-scheme-handler/tootle=com.github.bleakgrey.tootle.desktop
    application/x-yaml=code.desktop
    x-scheme-handler/mailto=re.sonny.Junction.desktop
    text/plain=code.desktop
    text/x-yaml=code.desktop
    application/x-shellscript=code.desktop
    x-scheme-handler/chrome=re.sonny.Junction.desktop
    application/x-extension-htm=re.sonny.Junction.desktop
    application/x-extension-html=re.sonny.Junction.desktop
    application/x-extension-shtml=re.sonny.Junction.desktop
    application/x-extension-xhtml=re.sonny.Junction.desktop
    application/x-extension-xht=re.sonny.Junction.desktop
    application/pdf=org.gnome.Evince.desktop

    [Added Associations]
    application/xhtml+xml=re.sonny.Junction.desktop
    text/markdown=code.desktop
    application/x-yaml=code.desktop
    text/plain=code.desktop
    application/x-shellscript=code.desktop
    x-scheme-handler/chrome=re.sonny.Junction.desktop
    application/x-extension-htm=re.sonny.Junction.desktop
    application/x-extension-html=re.sonny.Junction.desktop
    application/x-extension-shtml=re.sonny.Junction.desktop
    application/x-extension-xhtml=re.sonny.Junction.desktop
    application/x-extension-xht=re.sonny.Junction.desktop
  '';
}
