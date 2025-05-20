{
  config,
  pkgs,
  ...
}: {
  boot.extraModulePackages = [
    config.boot.kernelPackages.v4l2loopback
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';
  security.polkit.enable = true;

  # sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    pulse.enable = true;
  };
  services.pulseaudio.enable = false;

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
