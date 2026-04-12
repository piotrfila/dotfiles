{...}: {
  services.hyprpaper = {
    enable = true;
    settings = let
      wp = "~/Pictures/wallpapers/artemis.jpg";
    in {
      ipc = "off";
      preload = [
        "${wp}"
      ];
      splash = "false";
      wallpaper = [
        "eDP-1,${wp}"
        "DP-1,${wp}"
        "DP-2,${wp}"
        "HDMI-A-1,${wp}"
        "HDMI-A-2,${wp}"
      ];
    };
  };
  wayland.windowManager.hyprland.settings.exec-once = ["hyprpaper"];
}
