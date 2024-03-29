{ ... }: {
  # Add gitnuro theme
  home.file.".config/gitnauro/gitnauro-dracula.json".text = ''
       {
        "primary": "#BD93F9",
        "primaryVariant": "#BD93F9",
        "onPrimary": "#FFFFFF",
        "secondary": "#50FA7B",
        "onBackground": "#282A36",
        "onBackgroundSecondary": "#44475A",
        "error": "#FF5555",
        "onError": "#FFFFFF",
        "background": "#282A36",
        "backgroundSelected": "#44475A",
        "surface": "#373844",
        "secondarySurface": "#44475A",
        "tertiarySurface": "#44475A",
        "addFile": "#50FA7B",
        "deletedFile": "#FF5555",
        "modifiedFile": "#F1FA8C",
        "conflictingFile": "#FFB86C",
        "dialogOverlay": "#000000",
        "normalScrollbar": "#44475A",
        "hoverScrollbar": "#F1FA8C",
        "diffLineAdded": "#50FA7B",
        "diffLineRemoved": "#FF5555",
        "isLight": false
    }
  '';
}
