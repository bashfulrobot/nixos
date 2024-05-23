# Espanso on NixOs

 The below repo was written by a community member to get Espanso working on nix. It is a workaround to get Espanso working on NixOs.

# <https://github.com/ingbarrozo/espanso>

I drop their files into the modules/cli/espanso/ingbarrozo/espanso/build/ directory. THe name `build` is significant based on my use of auto imports. The `build` directory will have these files skipped for autoimports. I then manually bring it into my home-manager configuration.
