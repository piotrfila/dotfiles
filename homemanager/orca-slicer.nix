{
  config,
  pkgs,
  ...
}: let
  util = import ../util.nix;
in {
  home.persistence = util.persist {
    inherit config;
    directories = [
      ".config/OrcaSlicer"
      ".local/share/orca-slicer"
    ];
  };
  home.packages = [pkgs.orca-slicer];
}
