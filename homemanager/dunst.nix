{...}: {
  services.dunst = {
    enable = true;

    settings = {
      global = {
        width = "(200, 500)";
        height = 300;
        offset = "20x50";
        origin = "top-right";
        gap_size = 4;
        follow = "mouse";
        frame_width = 0;
        font = "MesloLGS Nerd Font 15";
        min_icon_size = 128;
      };

      spotify = {
        background = "#222222";
        foreground = "#aaaaaa";
      };

      urgency_normal = {
        background = "#222222";
        foreground = "#aaaaaa";
        timeout = 4;
      };
    };
  };
}
