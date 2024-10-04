# Plasma Config Notes

## Panel

The panel is a bit of a pain to configure. Plasma Managaer cannot do the panel.

- I set up my panel using the gui, which writes to `~/.config/plasma-org.kde.plasma.desktop-appletsrc`
- I then copied that file to `modules/desktops/kde/build/plasma-org.kde.plasma.desktop-appletsrc`
- and use home manager to place the file

### Potential Issues

- Will new changes to the panel in gui be lost? Or how to capture?
