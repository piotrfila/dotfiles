{
  config,
  pkgs,
  ...
}: {
  home.file = import ../util/persist.nix {
    inherit config;
    symlinks = [
      ".config/kicad"
      ".local/share/kicad"
    ];
  };
  home.packages = [pkgs.kicad];
}
