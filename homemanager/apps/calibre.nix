{
  config,
  pkgs,
  ...
}: {
  home.file = import ../util/persist.nix {
    inherit config;
    symlinks = [".config/calibre"];
  };
  home.packages = [pkgs.calibre];
  xdg.mimeApps.defaultApplications = import ../util/fill-with.nix {
    value = ["org.xfce.ristretto.desktop"];
    keys = ["application/epub+zip"];
  };
}
