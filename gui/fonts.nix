{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      nerd-fonts.fira-code
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
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
