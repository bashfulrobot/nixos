# NixOs

This repo contains the nixos cfg for a few of my systems. It tends to be under heavy development as I am still in the "keep trying things" phase of my Nix learnings. This repo has moved from Gnome -> Pantheon -> Hyprland - > Gnome -> sway -> Hyprland -> Gnome. You see where I am going with this. It "feels" like Gnome is where I plan to stay for some time. I found the user experience to be good, and the OOTB configuration seems to work best. It allows me to stop messing around to a degree and get "back to work."

## Status

WIP, forever.

## Code Flow

- All code under the `modules` folder is imported via `autoimport.nix`. The modules folder code is set up with options, which are not used unless you enable the options in your system config.
- the`modules` are then grouped into `suites` and enabled there. But can be enabled directly in the system config if you prefer or need a "one-off".
- The `suites` are then enabled in the `archetype`, a grouping (i.e., laptop, server, tower, workstation) of `suites` enabled for a specific system.
- Then `archetype` on the systems of choice

### Example of a system cfg

```

# Shows using the archetype to enable a laptop and workstation
archetype = {
    laptop.enable = true;
    workstation.enable = true;
  };

    # enable my user of choice
    # Note - still some refactoring in some modules to adjust if you move from a "dustin" user to an additional user or different user
    users.dustin.enable = true;

    # enable the desktop I want to use on this system
    desktops.pantheon.enable = true;

    # enable an app directly vs via an archetype or suite
    apps = {
        syncthing = {
            enable = true;
            host.evo = true;
        };

        # another exaple of direct module use
        desktopFile = {
        enable = true;
        reboot-firmware = true;
        seabird = true;
        beeper = true;
        monokle = true;
        cursor = true;
        spacedrive = true;
        };
    };
```

### Home Manager Useage

- I do use Home Manager, but not in the usual pattern.
- I hated having two different locations to configure the same application if I had to (or wanted to) use base nix and home manager config.
- So, I figured out how to have it all in one file.
The `modules/desktops/gnome/default.nix` have an excellent example of this. In that file you will see:

```
# Above is traditional NixOS config

##### Home Manager Config options #####
    home-manager.users."${username}" = {
# Everything in here is home-manager config
```

## Notes

### Espanso

The Espanso service is funny. At times, the service will not start after an update. The fix "seems" to be:

- `upgrade` the system.
- Unregister the Espanso service with `espanso service unregister`
- `reboot`, and let the `services.espanso.enable = true;` in my config, start the service.

### Getting StartupWMClass For Web Apps

Getting the StartupWMClass is a pain in Wayland.

#### Steps for my setup

- create the base desktop file, and rebuild
- open the app
- enable the looking-glass gnome extension
- open looking glass and go to `windows`
- take a screenshot of *ONLY* the class text
- press `ctrl-alt-o`, and it will run a script to OCR the text from my the screenshot and put the results on my clipboard
- paste it into the desktop file, and rebuild

## TODO

- Pantheon
    - [ ] small window controls
    - [ ] chromium web apps do not launch
    - [x] set my preferred keyboard shortcuts for:
        - [x] going to workspaces
        - [x] closing windows
        - [x] terminal launch
        - [x] 1password
    - [ ] no app indicators
    - [x] missing panel until you use Superkey
    - [ ] finish adding options to Pantheon for optional config
    - [x] set wallpaper
    - [ ] add a screenshot shortcut that accounts for the desktop keyboard
    - [ ] set user photo
    - [ ] The fingerprint reader seems to want a manual login after locking the laptop. You should be able to use a fingerprint.
- Firefox
    - [ ] change FF to be declarative
    - [ ] test FF web wrapper
- [ ] Test A********
