{
  config,
  pkgs,
  ...
}: {
  home.file = import ../util/persist.nix {
    inherit config;
    symlinks = [
      ".config/xfce4/xfconf/xfce-perchannel-xml/ristretto.xml"
    ];
  };
  home.packages = [pkgs.xfce.ristretto];
}
