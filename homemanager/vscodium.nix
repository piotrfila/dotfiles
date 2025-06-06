{
  pkgs,
  config,
  ...
}: let
  util = import ../util.nix;
in {
  home.file = util.persist {
    inherit config;
    symlinks = [".config/VSCodium"];
  };
  home.packages = [pkgs.vscodium];
  xdg.mimeApps.defaultApplications = util.fill-with {
    value = ["codium.desktop"];
    keys = [
      "application/ecmascript"
      "application/java"
      "application/javascript"
      "application/java-byte-code"
      "text/css"
      "text/javascript"
      "text/markdown"
      "text/pascal"
      "text/plain"
      "text/tab-separated-values"
      "text/x-asm"
      "text/x-c"
      "text/x-h"
      "text/x-java-source"
    ];
  };
}
