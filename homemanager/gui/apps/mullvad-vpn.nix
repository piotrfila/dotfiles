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
    {
      name = "mullvad_vpn";
      "match:class" = "^(Mullvad VPN)$";
      float = true;
      move = "11.7% 23.7%";
    }
  ];
}
