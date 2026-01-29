{
  config,
  pkgs,
  ...
}: let
  util = import ../util.nix;
in {
  home = {
    packages = [pkgs.calibre];
    persistence = util.persist {
      inherit config;
      directories = [".config/calibre"];
    };
  };
  xdg.mimeApps.defaultApplications = util.fill-with {
    value = ["org.xfce.ristretto.desktop"];
    keys = ["application/epub+zip"];
  };
}
