{ ... }: {
  # Add gitnuro theme
  home.file.".config/gitnauro/gitnauro-adwaita-dark.json".text = ''
       {
        "primary": "#729FCF",
        "primaryVariant": "#3465A4",
        "onPrimary": "#2E3436",
        "secondary": "#8AE234",
        "onBackground": "#2E3436",
        "onBackgroundSecondary": "#555753",
        "error": "#CC0000",
        "onError": "#2E3436",
        "background": "#2E3436",
        "backgroundSelected": "#555753",
        "surface": "#555753",
        "secondarySurface": "#555753",
        "tertiarySurface": "#555753",
        "addFile": "#4E9A06",
        "deletedFile": "#CC0000",
        "modifiedFile": "#C4A000",
        "conflictingFile": "#EF2929",
        "dialogOverlay": "#000000",
        "normalScrollbar": "#555753",
        "hoverScrollbar": "#729FCF",
        "diffLineAdded": "#4E9A06",
        "diffLineRemoved": "#CC0000",
        "isLight": false
    }
  '';
}