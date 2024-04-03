{ ... }: {
  # Add gitnuro theme
  home.file.".config/gitnauro/gitnauro-nord-dark.json".text = ''
       {
        "primary": "#88C0D0",
        "primaryVariant": "#81A1C1",
        "onPrimary": "#2E3440",
        "secondary": "#8FBCBB",
        "onBackground": "#D8DEE9",
        "onBackgroundSecondary": "#E5E9F0",
        "error": "#BF616A",
        "onError": "#D8DEE9",
        "background": "#2E3440",
        "backgroundSelected": "#3B4252",
        "surface": "#434C5E",
        "secondarySurface": "#4C566A",
        "tertiarySurface": "#5E81AC",
        "addFile": "#A3BE8C",
        "deletedFile": "#BF616A",
        "modifiedFile": "#D08770",
        "conflictingFile": "#EBCB8B",
        "dialogOverlay": "#000000",
        "normalScrollbar": "#4C566A",
        "hoverScrollbar": "#D08770",
        "diffLineAdded": "#A3BE8C",
        "diffLineRemoved": "#BF616A",
        "isLight": false
    }
  '';
}