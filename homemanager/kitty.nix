{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    font.name = "FiraCode Nerd Font Mono";
    font.size = 12;
    settings = let
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
      # The foreground color
      foreground = "#c0b18b";

      # The background color
      background = "#262626";
      background_opacity = "0.9";

      # The foreground for selections
      selection_foreground = col_normal.black;

      # The background for selections
      selection_background = col_normal.red;

      # The cursor color
      cursor = col_bright.green;

      # The cursor shape can be one of (block, beam, underline)
      cursor_shape = "block";

      # The interval (in seconds) at which to blink the cursor. Set to zero to
      # disable blinking.
      cursor_blink_interval = "0.5";

      # Stop blinking cursor after the specified number of seconds of keyboard inactivity. Set to
      # zero or a negative number to never stop blinking.
      cursor_stop_blinking_after = 15;

      # Number of lines of history to keep in memory for scrolling back
      scrollback_lines = 2000;

      # Program with which to view scrollback in a new window. The scrollback buffer is passed as
      # STDIN to this program. If you change it, make sure the program you use can
      # handle ANSI escape sequences for colors and text formatting.
      scrollback_pager = "less +G -R";

      # Wheel scroll multiplier (modify the amount scrolled by the mouse wheel)
      wheel_scroll_multiplier = "5.0";

      # The interval between successive clicks to detect double/triple clicks (in seconds)
      click_interval = "0.5";

      # Characters considered part of a word when double clicking. In addition to these characters
      # any character that is marked as an alpha-numeric character in the unicode
      # database will be matched.
      select_by_word_characters = ":@-./_~?&=%+#";

      # Hide mouse cursor after the specified number of seconds of the mouse not being used. Set to
      # zero or a negative number to disable mouse cursor hiding.
      mouse_hide_wait = "0.0";

      # The enabled window layouts. A comma separated list of layout names. The special value * means
      # all layouts. The first listed layout will be used as the startup layout.
      # For a list of available layouts, see the file layouts.py
      enabled_layouts = "*";

      # If enabled, the window size will be remembered so that new instances of kitty will have the same
      # size as the previous instance. If disabled, the window will initially have size configured
      # by initial_window_width/height, in pixels.
      remember_window_size = "no";
      initial_window_width = 640;
      initial_window_height = 400;

      # Delay (in milliseconds) between screen updates. Decreasing it, increases fps
      # at the cost of more CPU usage. The default value yields ~100fps which is more
      # that sufficient for most uses.
      # repaint_delay    10
      repaint_delay = 10;

      # Delay (in milliseconds) before input from the program running in the terminal
      # is processed. Note that decreasing it will increase responsiveness, but also
      # increase CPU usage and might cause flicker in full screen programs that
      # redraw the entire screen on each loop, because kitty is so fast that partial
      # screen updates will be drawn.
      input_delay = 3;

      # Visual bell duration. Flash the screen when a bell occurs for the specified number of
      # seconds. Set to zero to disable.
      visual_bell_duration = "0.0";

      # Enable/disable the audio bell. Useful in environments that require silence.
      enable_audio_bell = "no";

      # The modifier keys to press when clicking with the mouse on URLs to open the URL
      open_url_modifiers = "ctrl+shift";

      # The program with which to open URLs that are clicked on. The special value "default" means to
      # use the operating system's default URL handler.
      open_url_with = "default";

      # The value of the TERM environment variable to set
      term = "xterm-kitty";

      # The width (in pts) of window borders. Will be rounded to the nearest number of pixels based on screen resolution.
      window_border_width = 0;

      window_margin_width = 15;

      # The color for the border of the active window
      active_border_color = "#fff";

      # The color for the border of inactive windows
      inactive_border_color = "#ccc";

      # Tab-bar colors
      active_tab_foreground = "#000";
      active_tab_background = "#eee";
      inactive_tab_foreground = "#444";
      inactive_tab_background = "#999";

      # The 16 terminal colors. There are 8 basic colors, each color has a dull and
      # bright version.

      # black
      color0 = col_normal.black;
      color1 = col_normal.red;
      color2 = col_normal.green;
      color3 = col_normal.yellow;
      color4 = col_normal.blue;
      color5 = col_normal.magenta;
      color6 = col_normal.cyan;
      color7 = col_normal.white;
      color8 = col_bright.black;
      color9 = col_bright.red;
      color10 = col_bright.green;
      color11 = col_bright.yellow;
      color12 = col_bright.blue;
      color13 = col_bright.magenta;
      color14 = col_bright.cyan;
      color15 = col_bright.white;
    };
    shellIntegration.enableFishIntegration = true;
  };
}
