{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["FiraCode"];})
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["FiraCode Nerd Font Mono"];
        serif = ["Noto Serif" "Garamond"];
        sansSerif = ["Noto Sans"];
      };
    };
  };
}
