{
  config,
  pkgs,
  ...
}: let
  util = import ../util.nix;
in {
  home.file = util.persist {
    inherit config;
    symlinks = [
      ".config/OrcaSlicer"
      ".local/share/orca-slicer"
    ];
  };
  home.packages = [pkgs.orca-slicer];
}
