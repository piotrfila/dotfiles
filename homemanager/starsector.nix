{
  config,
  pkgs,
  ...
}: let
  util = import ../util.nix;
in {
  home = {
    packages = [pkgs.starsector];
    persistence = util.persist {
      inherit config;
      directories = [".local/share/starsector"];
    };
  };
}
