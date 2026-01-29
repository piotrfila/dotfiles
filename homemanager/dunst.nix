{pkgs, ...}: {
  home.packages = [pkgs.libnotify];
  services.dunst = {
    enable = true;
    settings = {
      global = {
        follow = "mouse";
        font = "FiraCode Nerd Font 15";
        frame_width = 0;
        gap_size = 4;
        height = 300;
        min_icon_size = 128;
        offset = "20x50";
        origin = "top-right";
        width = "(200, 500)";
      };
      spotify = {
        background = "#222222";
        foreground = "#aaaaaa";
        timeout = 4;
      };
      urgency_normal = {
        background = "#222222";
        foreground = "#aaaaaa";
        timeout = 4;
      };
    };
  };
  wayland.windowManager.hyprland.settings.exec-once = ["dunst"];
}
