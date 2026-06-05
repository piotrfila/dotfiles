{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./fonts.nix
    ./pipewire.nix
    ./thunar.nix
  ];

  environment.pathsToLink = ["/share/applications" "/share/xdg-desktop-portal"];

  programs = {
    dconf.enable = true;
    obs-studio.enableVirtualCamera = true;
  };
}
