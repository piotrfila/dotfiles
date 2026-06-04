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
      move = "(monitor_w*0.117) (monitor_h*0.237)";
    }
  ];
}
