{
  config,
  pkgs,
  ...
}: let
  util = import ../util.nix;
in {
  home.file = util.persist {
    inherit config;
    symlinks = [".local/share/starsector"];
  };
  home.packages = [pkgs.starsector];
}
