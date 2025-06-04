{
  config,
  pkgs,
  ...
}: {
  home.file = import ../util/persist.nix {
    inherit config;
    symlinks = [".config/discord"];
  };
  home.packages = [pkgs.discord];
}
