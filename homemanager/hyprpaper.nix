{...}: {
  services.hyprpaper = {
    enable = true;
    settings = let
      wp = "~/Pictures/wallpapers";
    in {
      ipc = "off";
      preload = [
        "${wp}/train.png"
      ];
      splash = "false";
      wallpaper = [
        "eDP-1,${wp}/train.png"
        "DP-1,${wp}/train.png"
        "DP-2,${wp}/train.png"
        "HDMI-A-1,${wp}/train.png"
        "HDMI-A-2,${wp}/train.png"
      ];
    };
  };
  wayland.windowManager.hyprland.settings.exec-once = ["hyprpaper"];
}
