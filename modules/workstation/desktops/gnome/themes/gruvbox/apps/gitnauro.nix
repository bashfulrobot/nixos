{ ... }: {
  # Add gitnuro theme
  home.file.".config/gitnauro/gitnauro-gruvbox-dark.json".text = ''
       {
        "primary": "#fabd2f",
        "primaryVariant": "#fabd2f",
        "onPrimary": "#282828",
        "secondary": "#83a598",
        "onBackground": "#282828",
        "onBackgroundSecondary": "#3c3836",
        "error": "#fb4934",
        "onError": "#282828",
        "background": "#282828",
        "backgroundSelected": "#3c3836",
        "surface": "#504945",
        "secondarySurface": "#3c3836",
        "tertiarySurface": "#3c3836",
        "addFile": "#b8bb26",
        "deletedFile": "#fb4934",
        "modifiedFile": "#fe8019",
        "conflictingFile": "#d65d0e",
        "dialogOverlay": "#000000",
        "normalScrollbar": "#3c3836",
        "hoverScrollbar": "#fe8019",
        "diffLineAdded": "#b8bb26",
        "diffLineRemoved": "#fb4934",
        "isLight": false
    }
  '';
}