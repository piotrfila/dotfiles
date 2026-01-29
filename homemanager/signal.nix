{
  config,
  pkgs,
  ...
}: let
  util = import ../util.nix;
in {
  home = {
    packages = [pkgs.signal-desktop];
    persistence = util.persist {
      inherit config;
      directories = [".config/Signal"];
    };
  };
}
