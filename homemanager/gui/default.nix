{osConfig, ...}: {
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
}
