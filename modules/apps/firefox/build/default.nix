{ stdenv, fetchzip, user-settings, ... }:
let
  profile_dir =
    "/home/${user-settings.user.username}/.mozilla/firefox/${user-settings.user.username}";
in stdenv.mkDerivation rec {
  pname = "firefox-gnome-theme";
  #   TODO: UPDATE ME
  version = "132";
  src = fetchzip {
    url =
      "https://github.com/rafaelmardojai/firefox-gnome-theme/archive/refs/tags/v${version}.zip";
    sha256 = "sha256-MOE9NeU2i6Ws1GhGmppMnjOHkNLl2MQMJmGhaMzdoJM="; # Replace with the actual sha256 value
  };

  buildPhase = "";
  installPhase = ''
    mkdir -p $out/chrome
    cp -r * $out/chrome/
  '';
}
