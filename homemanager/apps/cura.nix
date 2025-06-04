{
  config,
  pkgs,
  ...
}: {
  home.file = import ../util/persist.nix {
    inherit config;
    symlinks = [
      ".config/cura"
      ".local/share/cura"
    ];
  };
  home.packages = [pkgs.cura];
}
