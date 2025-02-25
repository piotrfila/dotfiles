{ pkgs, ... }: {
  i18n.inputMethod = {
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
  i18n.supportedLocales = [
    "C.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
    "pl_PL.UTF-8/UTF-8"
    # "POSIX"
    "ja_JP.UTF-8/UTF-8"
  ];
}