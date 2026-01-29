{
  config,
  pkgs,
  ...
}: let
  util = import ../util.nix;
in {
  home = {
    packages = [pkgs.orca-slicer];
    persistence = util.persist {
      inherit config;
      directories = [
        ".config/OrcaSlicer"
        ".local/share/orca-slicer"
      ];
    };
  };
}
