{ ... }: {
  # Add gitnuro theme
  home.file.".config/gitnauro/gitnauro-popos.json".text = ''
       {
        "primary": "#F15D22",
        "primaryVariant": "#F15D22",
        "onPrimary": "#F2F2F2",
        "secondary": "#73C48F",
        "onBackground": "#333333",
        "onBackgroundSecondary": "#88807C",
        "error": "#CC0000",
        "onError": "#F2F2F2",
        "background": "#333333",
        "backgroundSelected": "#88807C",
        "surface": "#333333",
        "secondarySurface": "#88807C",
        "tertiarySurface": "#88807C",
        "addFile": "#73C48F",
        "deletedFile": "#CC0000",
        "modifiedFile": "#FFCE51",
        "conflictingFile": "#F15D22",
        "dialogOverlay": "#333333",
        "normalScrollbar": "#88807C",
        "hoverScrollbar": "#FFCE51",
        "diffLineAdded": "#73C48F",
        "diffLineRemoved": "#CC0000",
        "isLight": false
    }
  '';
}
