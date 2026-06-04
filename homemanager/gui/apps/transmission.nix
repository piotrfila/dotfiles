{
  config,
  pkgs,
  ...
}: let
  util = import ../../../util.nix;
in {
  home = {
    packages = [pkgs.transmission_4-qt];
    persistence = util.persist {
      inherit config;
      directories = [".config/transmission"];
    };
  };
}
