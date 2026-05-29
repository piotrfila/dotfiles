{pkgs, ...}: {
  programs = {
    thunar.enable = true;
    thunar.plugins = with pkgs; [
      thunar-archive-plugin
      thunar-volman
    ];
    xfconf.enable = true;
  };

  services = {
    gvfs.enable = true;
    tumbler.enable = true;
  };
}
