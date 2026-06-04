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

  programs = {
    dconf.enable = true;
    obs-studio.enableVirtualCamera = true;
  };
}
