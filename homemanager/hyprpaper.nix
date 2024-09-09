{...}: {
  services.hyprpaper = {
    enable = true;
    settings = let
      wp = "~/Pictures/wallpapers";
    in {
      ipc = "off";
      splash = "false";

      preload = [
        "${wp}/autumn.png"
      ];

      wallpaper = [
        "eDP-1,${wp}/autumn.png"
        "DP-1,${wp}/autumn.png"
        "DP-2,${wp}/autumn.png"
        "HDMI-A-1,${wp}/autumn.png"
        "HDMI-A-2,${wp}/autumn.png"
      ];
    };
  };
}
