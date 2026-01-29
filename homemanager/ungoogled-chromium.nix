{
  config,
  pkgs,
  ...
}: let
  util = import ../util.nix;
in {
  home = {
    packages = [pkgs.ungoogled-chromium];
    persistence = util.persist {
      inherit config;
      directories = [".config/chromium"];
    };
  };
}
