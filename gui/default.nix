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

  security = {
    pam.services.gdm.enableGnomeKeyring = true;
    polkit.enable = true;
  };

  services.gnome.gnome-keyring.enable = true;
}
