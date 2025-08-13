{
  config,
  pkgs,
  ...
}: let
  util = import ../util.nix;
in {
  home.file = util.persist {
    inherit config;
    symlinks = [".config/Signal"];
  };
  home.packages = [pkgs.signal-desktop];
}
