{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      nerdfonts
      noto-fonts
      noto-fonts-cjk
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
