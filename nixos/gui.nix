{ config, pkgs, ... }: {
  boot.extraModulePackages = [
    config.boot.kernelPackages.v4l2loopback
  ];

  # sound
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    pulse.enable = true;
  };
  sound.enable = true;

  # environment.etc = let
  #   gtk-settings = ''
  #     gtk-error-bell=false
  #     gtk-application-prefer-dark-theme=1
  #   '';
  # in {
  #   "xdg/gtk-2.0/gtkrc".text = ''
  #     ${gtk-settings}
  #   '';
  #   "xdg/gtk-3.0/settings.ini".text = ''
  #     [Settings]
  #     ${gtk-settings}
  #   '';
  #   "xdg/gtk-4.0/settings.ini".text = ''
  #     [Settings]
  #     ${gtk-settings}
  #   '';
  # };
  
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  # keyring
  security.pam.services.gdm.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;
}