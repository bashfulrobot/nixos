# Proper Icons in alt-tab

The `StartupWMClass` in the desktop file MUST match the actual WMCLass of the window to make icons match in alt-tab.
Build the desktop file and create it

- open the app
`alt-f2` followed by lg. Select the "windows tab," and you can see the class names of the open windows.
Generally, it should be something like `StartupWMClass=chrome-docs.sysdig.com__en_-Default`I will test a few more and see if it follows this pattern for all.
