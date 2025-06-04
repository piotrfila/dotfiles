{
  config,
  pkgs,
  ...
}: {
  home.file = import ../util/persist.nix {
    inherit config;
    symlinks = [
      ".config/OrcaSlicer"
      ".local/share/orca-slicer"
    ];
  };
  home.packages = [pkgs.orca-slicer];
}
