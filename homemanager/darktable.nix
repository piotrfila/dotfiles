{
  config,
  pkgs,
  ...
}: let
  util = import ../util.nix;
in {
  home.file = util.persist {
    inherit config;
    symlinks = [".config/darktable"];
  };
  home.packages = [pkgs.darktable];
}
