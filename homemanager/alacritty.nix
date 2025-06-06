{...}: {
  programs.alacritty = {
    enable = true;
    settings = let
      font = "FiraCode Nerd Font Mono";
    in {
      window.padding = {
        x = 20;
        y = 20;
      };
      window.opacity = 0.9;

      font = {
        normal.family = font;
        bold.family = font;
        italic.family = font;
        bold_italic.family = font;
        size = 12;
      };

      colors.primary = {
        foreground = "#c0b18b";
        background = "#262626";

        # # The foreground for selections
        # selection_foreground = "#2f2f2f";

        # # The background for selections
        # selection_background = "#d75f5f";
      };

      colors.cursor = {
        text = "#8fee96";
        cursor = "#8fee96";
      };

      colors.selection = {
        text = "#2f2f2f";
        background = "#d75f5f";
      };

      colors.normal = {
        black = "#2f2f2f";
        red = "#d75f5f";
        green = "#d4d232";
        yellow = "#af865a";
        blue = "#22c3a1";
        magenta = "#775759";
        cyan = "#84edb9";
        white = "#c0b18b";
      };

      colors.bright = {
        black = "#656565";
        red = "#d75f5f";
        green = "#8fee96";
        yellow = "#cd950c";
        blue = "#22c3a1";
        magenta = "#775759";
        cyan = "#84edb9";
        white = "#d8d8d8";
      };

      cursor = {
        style.blinking = "On";
        style.shape = "Beam";
        blink_interval = 500;
        blink_timeout = 15;
        thickness = 0.1;
        unfocused_hollow = true;
      };
    };
  };
}
