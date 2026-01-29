{
  config,
  pkgs,
  ...
}: let
  util = import ../util.nix;
in {
  home = {
    packages = [pkgs.darktable];
    persistence = util.persist {
      inherit config;
      directories = [".config/darktable"];
    };
  };
}
