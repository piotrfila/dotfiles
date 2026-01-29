{
  config,
  pkgs,
  ...
}: let
  util = import ../util.nix;
in {
  home = {
    packages = [pkgs.discord];
    persistence = util.persist {
      inherit config;
      directories = [".config/discord"];
    };
  };
}
