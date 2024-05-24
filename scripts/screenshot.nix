{ pkgs }:

pkgs.writeShellScriptBin "screenshot" ''
  cd ~/Pictures/Screenshots/
  ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)"
''