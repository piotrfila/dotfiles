{...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      colors = let
        col_bright = {
          black = "#656565";
          red = "#d75f5f";
          green = "#8fee96";
          yellow = "#cd950c";
          blue = "#22c3a1";
          magenta = "#775759";
          cyan = "#84edb9";
          white = "#d8d8d8";
        };
        col_normal = {
          black = "#2f2f2f";
          red = "#d75f5f";
          green = "#d4d232";
          yellow = "#af865a";
          blue = "#22c3a1";
          magenta = "#775759";
          cyan = "#84edb9";
          white = "#c0b18b";
        };
      in {
        bright = col_bright;
        cursor.text = col_bright.green;
        cursor.cursor = col_bright.green;
        normal = col_normal;
        primary.foreground = col_normal.white;
        primary.background = "#262626";
        # primary.selection_foreground = col_normal.black;
        # primary.selection_background = col_normal.red;
        selection.text = col_normal.black;
        selection.background = col_normal.red;
      };
      cursor = {
        style.blinking = "On";
        style.shape = "Beam";
        blink_interval = 500;
        blink_timeout = 15;
        thickness = 0.1;
        unfocused_hollow = true;
      };
      font = let
        font = "FiraCode Nerd Font Mono";
      in {
        normal.family = font;
        bold.family = font;
        italic.family = font;
        bold_italic.family = font;
        size = 12;
      };
      window = {
        opacity = 0.9;
        padding.x = 20;
        padding.y = 20;
      };
    };
  };
}
