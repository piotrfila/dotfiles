{
  config,
  pkgs,
  ...
}: let
  util = import ../../../util.nix;
in {
  home = {
    packages = [
      pkgs.gnuradio
      pkgs.gqrx
    ];
  };
}
