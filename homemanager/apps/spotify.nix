{
  config,
  pkgs,
  ...
}: {
  home.file = import ../util/persist.nix {
    inherit config;
    symlinks = [".config/spotify"];
  };
  home.packages = [pkgs.spotify];
}
