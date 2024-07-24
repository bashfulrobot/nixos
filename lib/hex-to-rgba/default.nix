{ lib }:
{
# Inputs: hexColor is a string like "#RRGGBB", opacity is a float between 0 and 1
hexColor, opacity }:
let
  # Remove the leading '#' and convert to uppercase for consistency
  cleanHex = lib.removePrefix "#" (lib.toUpper hexColor);

  # Convert a two-character hex string to decimal
  hexToDec = hexStr: lib.fromHexString hexStr;

  # Extract RGB components
  r = hexToDec (lib.substring 0 2 cleanHex);
  g = hexToDec (lib.substring 2 2 cleanHex);
  b = hexToDec (lib.substring 4 2 cleanHex);

  # Calculate the alpha value for rgba (255 scale)alpha = lib.truncate (opacity * 255);
  alpha = builtins.floor (opacity * 255);
  # Construct the rgba string
in "rgba(${toString r}, ${toString g}, ${toString b}, ${toString alpha})"
