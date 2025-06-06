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
      ".config/cura"
      ".local/share/cura"
    ];
  };
  home.packages = [pkgs.cura];
}
