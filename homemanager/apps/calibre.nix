{
  config,
  pkgs,
  ...
}: let
  util = import ../util.nix;
in {
  home.file = util.persist {
    inherit config;
    symlinks = [".config/calibre"];
  };
  home.packages = [pkgs.calibre];
  xdg.mimeApps.defaultApplications = util.fill-with {
    value = ["org.xfce.ristretto.desktop"];
    keys = ["application/epub+zip"];
  };
}
