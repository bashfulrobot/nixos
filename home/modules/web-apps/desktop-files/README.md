The `StartupWMClass` in the desktop file MUST match the actual WMCLass of the window to make icons match in alt-tab.

- build the desktop file and create it
- open the app
- `alt-f2` followed by `lg`
- select the "windows tab" and you can see the class names of the open windows.
- Generally it should be something like `StartupWMClass=chrome-docs.sysdig.com__en_-Default`
- Will test a few more and see if it follows this pattern for all.
- I also like to create a web app in `epiphany` to get the icons for the webapp and delete it after.
