# NixOs

This is the nixos cfg for a few of my systems. It tends to be under heavy dev as I am still in the "keep trying things" phase of my nix learnings. This repo has moved from Gnome -> Pantheon -> Hyprland - > Gnome -> sway -> Hyprland -> Gnome. You see where I am going with this. It "feels" like gnome is where I plan to stay for some time. I found the user experience, and the OOTB config seems to work best, and allows me to stop messing around to a degree and get "back to work".

## Status

WIP, forever.

## Notes

### Espanso

The Espanso service is funny. At times the service will not start after an update. The fix "seems" to be:

- `upgrade` the system
- unregister the espanso service with `espanso service unregister`
- `reboot`, and let the `services.espanso.enable = true;` in my config start the service.

## TODO

- I still don't like my structure
- I send to follow KISS, but I am likely only scratching the surface in nix.
