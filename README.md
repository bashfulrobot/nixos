# NixOs

This repo contains the nixos cfg for a few of my systems. It tends to be under heavy development as I am still in the "keep trying things" phase of my Nix learnings. This repo has moved from Gnome -> Pantheon -> Hyprland - > Gnome -> sway -> Hyprland -> Gnome. You see where I am going with this. It "feels" like Gnome is where I plan to stay for some time. I found the user experience to be good, and the OOTB configuration seems to work best. It allows me to stop messing around to a degree and get "back to work."

## Status

WIP, forever.

## Notes

### Espanso

The Espanso service is funny. At times, the service will not start after an update. The fix "seems" to be:

- `upgrade` the system.
- Unregister the Espanso service with `espanso service unregister`
- `reboot`, and let the `services.espanso.enable = true;` in my config, start the service.

### Getting StartupWMClass For Web Apps

Getting the StartupWMClass is a pain in wayland.

#### Steps for my setup

- create the base desktop file, and rebuild
- open the app
- enable the looking glass gnome extension
- open looking glass and go to `windows`
- take a screenshot of *ONLY* the class text
- press `ctrl-alt-o` and it will run a script to OCR the text from my the screenshot and put the results on my clipboard
- paste it into the desktop file, and rebuild

## TODO

- I still don't like my structure
- I like to follow the KISS method, but I am likely only scratching the surface in Nix.
