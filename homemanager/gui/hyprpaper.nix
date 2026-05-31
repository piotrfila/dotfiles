{...}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = false;
      splash = false;
      wallpaper = {
        monitor = "";
        path = "~/Pictures/wallpapers/artemis.jpg";
        fit_mode = "cover";
      };
    };
  };
  wayland.windowManager.hyprland.settings.exec-once = ["hyprpaper"];
}
