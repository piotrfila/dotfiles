{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    font.name = "FiraCode Nerd Font Mono";
    font.size = 12;
    settings = {
      # The foreground color
      foreground = "#c0b18b";

      # The background color
      background = "#262626";
      background_opacity = "0.9";

      # The foreground for selections
      selection_foreground = "#2f2f2f";

      # The background for selections
      selection_background = "#d75f5f";

      # The cursor color
      cursor = "#8fee96";

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
      active_border_color = "#ffffff";

      # The color for the border of inactive windows
      inactive_border_color = "#cccccc";

      # Tab-bar colors
      active_tab_foreground = "#000";
      active_tab_background = "#eee";
      inactive_tab_foreground = "#444";
      inactive_tab_background = "#999";

      # The 16 terminal colors. There are 8 basic colors, each color has a dull and
      # bright version.

      # black
      color0 = "#2f2f2f";
      color8 = "#656565";

      # red
      color1 = "#d75f5f";
      color9 = "#d75f5f";

      # green
      color2 = "#d4d232";
      color10 = "#8fee96";

      # yellow
      color3 = "#af865a";
      color11 = "#cd950c";

      # blue
      color4 = "#22c3a1";
      color12 = "#22c3a1";

      # magenta
      color5 = "#775759";
      color13 = "#775759";

      # cyan
      color6 = "#84edb9";
      color14 = "#84edb9";

      # white
      color7 = "#c0b18b";
      color15 = "#d8d8d8";
    };
    shellIntegration.enableFishIntegration = true;
  };
}
