{
  config,
  pkgs,
  ...
}: let
  util = import ../util.nix;
in {
  home.file = util.persist {
    inherit config;
    symlinks = [
      ".config/kicad"
      ".local/share/kicad"
    ];
  };
  home.packages = [pkgs.kicad];
}
