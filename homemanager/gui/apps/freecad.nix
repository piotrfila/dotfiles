{
  config,
  pkgs,
  ...
}: let
  util = import ../../../util.nix;
  unstable = import <nixos-unstable> {};
  freecad = unstable.freecad;
in {
  home = {
    packages = [
      # workaround for fcitx input method crash
      (pkgs.writeShellScriptBin "freecad" ''
        QT_IM_MODULE=wayland ${freecad}/bin/freecad "$@"
      '')
    ];
    persistence = util.persist {
      inherit config;
      directories = [
        ".config/FreeCAD"
        ".local/share/FreeCAD"
      ];
    };
  };
  xdg.desktopEntries.freecad = {
    name = "FreeCAD";
    exec = "freecad %F";
    icon = "${freecad}/share/icons/hicolor/scalable/apps/org.freecad.FreeCAD.svg";
  };
}
