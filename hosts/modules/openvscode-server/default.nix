{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    openvscode-server # vscode in browser. Used for demos
  ];

  services.openvscode-server = {
    enable = true;
    user = "dustin";
    port = 8080;
    host = "localhost";
    extensionsDir = "/home/dustin/.vscode-oss/extensions";
    withoutConnectionToken = true; # So you don't need to grab the token that it generates here
  };
}
