{pkgs, ...}: {
  programs = {
    thunar.enable = true;
    thunar.plugins = [
      pkgs.thunar-archive-plugin
      pkgs.thunar-volman
    ];
    xfconf.enable = true;
  };

  services = {
    gvfs.enable = true;
    tumbler.enable = true;
  };
}
