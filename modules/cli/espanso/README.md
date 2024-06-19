# Espanso on NixOs

A community member wrote the below repo to get Espanso working on Nix. It is a workaround to get Espanso working on NixOs.

- ingbarrozo/espanso [GitHub Repo](https://github.com/ingbarrozo/espanso)

I drop their files into the `modules/cli/espanso/ingbarrozo/espanso/build/` directory. The name `build` is significant based on my use of auto imports. The `build` directory will have these files skipped for autoimports. I then manually bring it into my home-manager configuration.
