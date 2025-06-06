{
  config,
  pkgs,
  ...
}: let
  util = import ../util.nix;
in {
  home.file = util.persist {
    inherit config;
    symlinks = [".config/fcitx5"];
  };
  wayland.windowManager.hyprland.settings = {
    env = [
      "XMODIFIERS,@im=fcitx"
      "XMODIFIER,@im=fcitx"
      #"GTK_IM_MODULE,fcitx"
      "QT_IM_MODULE,fcitx"
      "QT_IM_MODULEs,wayland;fcitx;ibus"
    ];
    exec-once = ["fcitx5 -d"];
  };
}
