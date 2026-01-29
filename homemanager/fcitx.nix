{
  config,
  pkgs,
  ...
}: let
  util = import ../util.nix;
in {
  home.persistence = util.persist {
    inherit config;
    directories = [".config/fcitx5"];
  };
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
      ];
      waylandFrontend = true;
    };
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
