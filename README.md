# NixOs

This repo contains the nixos cfg for a few of my systems. It tends to be under heavy development as I am still in the "keep trying things" phase of my Nix learnings. This repo has moved from Gnome -> Pantheon -> Hyprland - > Gnome -> sway -> Hyprland -> Gnome. You see where I am going with this. It "feels" like Gnome is where I plan to stay for some time. I found the user experience to be good, and the OOTB configuration seems to work best. It allows me to stop messing around to a degree and get "back to work."

Which NIX is causing me to fail right now. I am "back to work." :)

## Status

WIP, forever.

## Code Flow

- All code under the `modules` folder is imported via `autoimport.nix`. The modules folder code is set up with options, which are not used unless you enable the options in your system config.
Then, `archetype` on the systems of choice

### Example of a system cfg

```nix

# Shows using the archetype to enable a laptop and workstation
archetype = {
    laptop.enable = true;
    workstation.enable = true;
  };

    # enable my user of choice
    # Note - still some refactoring in some modules to adjust if you move from a "dustin" user to an additional user or different user
    users.dustin.enable = true;

    # enable the desktop I want to use on this system
    desktops.gnome.enable = true;

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

### Home Manager Usage

- I do use Home Manager, but not in the usual pattern.
- I hated having two different locations to configure the same application if I had to (or wanted to) use base nix and home manager config.
- So, I figured out how to have it all in one file.
  The `modules/desktops/gnome/default.nix` have an excellent example of this. In that file, you will see:

```nix
# Above is traditional NixOS config

##### Home Manager Config options #####
    home-manager.users."${user-settings.user.username}" = {
# Everything in here is home-manager config
```

### Keyring

At times, I have had it where the keyring would not unlock. The solution was to go nuclear with `rm ~/.local/share/keyrings/login.keyring`, reboot, and let the keyring be recreated.
be sure to run `ssh-add ~/.ssh/id_ed25519` and `ssh-add ~/.ssh/id_rsa` after reboot. Ensure ssh-agent is running.

### Secrets

- My secrets just use `git-crypt`.
- I know about SOPs, etc., but I wanted to be able to make a secret substitution in my code.
  You can see its use in `modules/cli/git/default.nix`, such as (I was rendering a config file for a tool):

```toml
[openai]
        api_base = "https://api.openai.com/v1"
        api_key = "${secrets.openai.api-key}"
        #model = "gpt-3.5-turbo-16k"
        retries = 2
        proxy = ""
```

## Notes

### Espanso

The Espanso service is funny. At times, the service will not start after an update. The fix "seems" to be:

- `upgrade` the system.
- Unregister the Espanso service with `espanso service unregister`
- `reboot`, and let the `services.espanso.enable = true;` in my config, start the service.

### Getting StartupWMClass For Web Apps

#### Gnome

Getting the StartupWMClass is a pain in Wayland.

- I enabled the `Window Class` extension in Gnome.
- Then, you can use a command to get the window's class.
- See the `get_wm_class`` fish shell function in my`fish` module.

#### Sway

- I have a fish shell function to get the app id for the currently focused window. (`get_appid`)

#### Steps for my setup

Note: I use Brave, which also works with Chromium or any browser supporting the same cli flags. You can set the desired browser in the module where you define the web app. See `modules/apps/gcal-br/default.nix` for an example.

- Temporarily create a desktop shortcut for the site to wrap in brave
- Copy the icons using the `lib/cbb-webwrap/copy-icons.`sh` script
- Delete the app in brave
- run `brave --new-window --app="https://URL"` and leave it running
- Run `get_wm_class` in the terminal to get the StartupWMClass (save it somewhere)
- I have a nix function for creating a web app in `lib/cbb-webwrap/default.nix`An excellent example of how to use that nix function can be seen in `modules/apps/gcal-br/default.nix`
- Icons will be funky until you log out and back in or reboot
- Enable web app in the `modules/archetype/workstation.nix` file (or as appropriate in your setup)
- rebuild

## TODO

- sway
    - [ ] Waybar: module backlight: Disabling module "backlight", No backlight found
    - [ ] Waybar: some font awesome icons not showing in right side modules
    - [ ] Waybar: add bluetooth icon, and lauch config app
    - [ ] Waybar: ws 3 showing incorrect icon
    - [ ] Waybar: [error] media stopped unexpectedly, is it endless?
    - [ ] Waybar: [warning] Requested height: 5 is less than the minimum height: 27 required by the modules
    - [ ] Waybar: make battery module optional on tower (no battery)
    - [ ] Waybar: [warning] Mapping is not an object
    - [ ] Waybar: [warning] Requested height: 5 is less than the minimum height: 27 required by the modules
    - [ ] Sway: some apps not repecting rules for which ws to open on
    - [x] Login: greetd tui showing boot text over login form (now using regreet)
    - [ ] Login: keyring is not unlocking (now using regreet)
    - [x] Login: maybe an alternate login manager?
    - [ ] Theme: currently catppuccin, but gtk theme seems to be going away. Consider stock adwaita, or maybe yaru. Less theming to worry about.
    - [ ] Reboot: Add desktop file
    - [ ] Shutdown: Add desktop file
    - [ ] Sleep: Add desktop file
