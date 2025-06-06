{pkgs, ...}: let
  util = import ../util.nix;
in {
  home-manager.users.kaliko = {config, ...}: {
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
  };

  i18n = {
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        addons = with pkgs; [
          fcitx5-mozc-ut
          fcitx5-gtk
        ];
        waylandFrontend = true;
      };
    };
    supportedLocales = [
      "C.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
      "pl_PL.UTF-8/UTF-8"
      # "POSIX"
      "ja_JP.UTF-8/UTF-8"
    ];
  };
}
