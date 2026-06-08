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
    sessionVariables.GRC_PREFS_PATH = "${config.xdg.configHome}/GNU Radio/";
  };
}
