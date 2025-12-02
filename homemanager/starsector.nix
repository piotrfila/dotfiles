{
  config,
  pkgs,
  ...
}: let
  util = import ../util.nix;
in {
  home.persistence = util.persist {
    inherit config;
    directories = [".local/share/starsector"];
  };
  home.packages = [pkgs.starsector];
}
