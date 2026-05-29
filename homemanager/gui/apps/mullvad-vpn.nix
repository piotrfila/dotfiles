{
  config,
  pkgs,
  ...
}: let
  util = import ../../../util.nix;
in {
  home = {
    packages = [pkgs.mullvad-vpn];
    persistence = util.persist {
      inherit config;
      directories = [".config/Mullvad VPN"];
    };
  };
  wayland.windowManager.hyprland.settings.windowrule = [
    "float on,match:class ^(Mullvad VPN)$"
    "move 11.7% 23.7%,match:class ^(Mullvad VPN)$"
  ];
}
