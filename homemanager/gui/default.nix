{
  config,
  osConfig,
  ...
}: let
  util = import ../../util.nix;
in {
  imports =
    [
      ./dunst.nix
      ./fcitx.nix
      ./hyprland.nix
      ./hyprpaper.nix
      ./pulseview.nix
      ./themes.nix
      ./waybar.nix
      ./wofi.nix
    ]
    ++ (
      if osConfig.hardware.rtl-sdr.enable
      then [./apps/rtl-sdr.nix]
      else []
    )
    ++ (
      if osConfig.programs.obs-studio.enableVirtualCamera
      then [./apps/obs-studio.nix]
      else []
    )
    ++ (
      if osConfig.services.mullvad-vpn.enable
      then [./apps/mullvad-vpn.nix]
      else []
    )
    ++ (
      if osConfig.programs.steam.enable
      then [./apps/steam.nix]
      else []
    )
    ++ (
      if osConfig.programs.thunar.enable
      then [./apps/thunar.nix]
      else []
    );

  home.persistence = util.persist {
    inherit config;
    directories = [
      ".config/xfce4/xfconf/xfce-perchannel-xml"
      ".factorio"
      ".local/state/wireplumber"
      ".pki"
      "Documents"
      "Downloads"
      "Pictures"
    ];
    files = [".local/share/recently-used.xbel"];
  };

  xdg = {
    autostart.enable = true;
    mimeApps.enable = true;
  };
}
