{
  config,
  pkgs,
  ...
}: let
  util = import ../../../util.nix;
in {
  home.persistence = util.persist {
    inherit config;
    files = [".config/keepassxc"];
  };
  programs.keepassxc = {
    enable = true;
    autostart = true;
  };
  wayland.windowManager.hyprland.settings.windowrule = [
    {
      name = "keepassxc_browser_integration";
      "match:title" = "^(KeePassXC - Browser Access Request)$";
      float = true;
      move = "(monitor_w*0.30) (monitor_h*0.30)";
      size = "(monitor_w*0.40) (monitor_h*0.40)";
    }
  ];
}
