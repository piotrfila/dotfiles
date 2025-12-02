{
  config,
  pkgs,
  ...
}: let
  util = import ../util.nix;
in {
  home.persistence = util.persist {
    inherit config;
    directories = [".config/darktable"];
  };
  home.packages = [pkgs.darktable];
}
