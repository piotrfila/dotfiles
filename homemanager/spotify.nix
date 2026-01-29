{
  config,
  pkgs,
  ...
}: let
  util = import ../util.nix;
in {
  home = {
    packages = [pkgs.spotify];
    persistence = util.persist {
      inherit config;
      directories = [".config/spotify"];
    };
  };
}
