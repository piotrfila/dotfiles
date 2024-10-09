{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = [(pkgs.nerdfonts.override {fonts = ["FiraCode"];})];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = ["FiraCode Nerd Font Mono"];
      serif = ["Noto Serif" "Garamond"];
      sansSerif = ["Noto Sans"];
    };
  };
}
