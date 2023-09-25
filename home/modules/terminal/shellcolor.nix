{ config, ... }:
let inherit (config.colorscheme) colors;
in {
  programs.shellcolor = {
    enable = true;
    enableFishSshFunction = config.programs.fish.enable;
    enableBashSshFunction = config.programs.bash.enable;

    settings = {
      base00 = "${colors.base00}";
      base01 = "${colors.base01}";
      base02 = "${colors.base02}";
      base03 = "${colors.base03}";
      base04 = "${colors.base04}";
      base05 = "${colors.base05}";
      base06 = "${colors.base06}";
      base07 = "${colors.base07}";
      base08 = "${colors.base08}";
      base09 = "${colors.base09}";
      base0A = "${colors.base0A}";
      base0B = "${colors.base0B}";
      base0C = "${colors.base0C}";
      base0D = "${colors.base0D}";
      base0E = "${colors.base0E}";
      base0F = "${colors.base0F}";
    };
  };
}
# https://github.com/eyadsibai/dotfiles/blob/0f2b850c2aa5e1fc2a25dd4d7f7e39cb6d17f9c8/hosts/common/home-manager/shellcolor.nix
