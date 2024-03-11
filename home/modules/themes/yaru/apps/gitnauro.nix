{ ... }: {
  # Add gitnuro theme
  home.file.".config/gitnauro/gitnauro-yaru-dark.json".text = ''
       {
        "primary": "#2C001E",
        "primaryVariant": "#4C2294",
        "onPrimary": "#F2F2F2",
        "secondary": "#50FA7B",
        "onBackground": "#2C001E",
        "onBackgroundSecondary": "#4C2294",
        "error": "#FF5555",
        "onError": "#F2F2F2",
        "background": "#2C001E",
        "backgroundSelected": "#4C2294",
        "surface": "#4C2294",
        "secondarySurface": "#4C2294",
        "tertiarySurface": "#4C2294",
        "addFile": "#50FA7B",
        "deletedFile": "#FF5555",
        "modifiedFile": "#F1FA8C",
        "conflictingFile": "#FF6E6E",
        "dialogOverlay": "#000000",
        "normalScrollbar": "#4C2294",
        "hoverScrollbar": "#F2F2F2",
        "diffLineAdded": "#50FA7B",
        "diffLineRemoved": "#FF5555",
        "isLight": false
    }
  '';
}