{
  config,
  pkgs,
  ...
}: {
  home.file = import ../util/persist.nix {
    inherit config;
    symlinks = [".config/calibre"];
  };
  home.packages = [pkgs.calibre];
}
