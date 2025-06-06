{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./fcitx.nix
    ./fonts.nix
    ./pipewire.nix
    ./thunar.nix
  ];

  programs = {
    dconf.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    obs-studio.enableVirtualCamera = true;
  };

  security = {
    pam.services.gdm.enableGnomeKeyring = true;
    polkit.enable = true;
  };

  services.gnome.gnome-keyring.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
}
