# NixOS Kolide Notes

## Getting the secret

- log in as an admin
- add a device
- download the deb
- extract the secret from the deb file

## How to Extract the Secret on NixOS

- Login to [Kolide](app.kolide.com) as an admin
- download the deb from `/settings/my/downloads`
- cd to download location and `mkdir tmp`
- install dpkg temporarily: `nix-shell -p dpkg`
- inside the shell, run `dpkg-deb -R kolide-launcher.deb tmp` to unpack the deb into the `tmp` directory
- extract the secret: `cat tmp/etc/kolide-k2/secret`
- exit nix shell
