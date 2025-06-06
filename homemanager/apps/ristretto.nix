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
      ".config/xfce4/xfconf/xfce-perchannel-xml/ristretto.xml"
    ];
  };
  home.packages = [pkgs.xfce.ristretto];
  xdg.mimeApps.defaultApplications = util.fill-with {
    value = ["org.xfce.ristretto.desktop"];
    keys = [
      "image/bmp"
      "image/cmu-raster"
      "image/fif"
      "image/florian"
      "image/g3fax"
      "image/gif"
      "image/ief"
      "image/jpeg"
      "image/jutvision"
      "image/naplps"
      "image/pict"
      "image/pjpeg"
      "image/png"
      "image/tiff"
      "image/vasa"
      "image/vnd.dwg"
      "image/vnd.fpx"
      "image/vnd.net-fpx"
      "image/vnd.rn-realflash"
      "image/vnd.rn-realpix"
      "image/vnd.wap.wbmp"
      "image/vnd.xiff"
      "image/xbm"
      "image/x-cmu-raster"
      "image/x-dwg"
      "image/x-icon"
      "image/x-jg"
      "image/x-jps"
      "image/x-niff"
      "image/x-pcx"
      "image/x-pict"
      "image/xpm"
      "image/x-portable-anymap"
      "image/x-portable-bitmap"
      "image/x-portable-graymap"
      "image/x-portable-greymap"
      "image/x-portable-pixmap"
      "image/x-quicktime"
      "image/x-rgb"
      "image/x-tiff"
      "image/x-windows-bmp"
      "image/x-xbitmap"
      "image/x-xbm"
      "image/x-xpixmap"
      "image/x-xwd"
      "image/x-xwindowdump"
    ];
  };
}
