{
  config,
  pkgs,
  ...
}: {
  home.file = import ../util/persist.nix {
    inherit config;
    symlinks = [".config/chromium"];
  };
  home.packages = [pkgs.ungoogled-chromium];
}
