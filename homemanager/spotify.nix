{
  config,
  pkgs,
  ...
}: let
  util = import ../util.nix;
in {
  home.persistence = util.persist {
    inherit config;
    directories = [".config/spotify"];
  };
  home.packages = [pkgs.spotify];
}
