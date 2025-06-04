{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../scripts/screenshot.nix
    ../../scripts/toggle-calc.nix
  ];

  home.file = import ../util/persist.nix {
    inherit config;
    symlinks = [".config/hypr/extra.conf"];
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;

    settings = {
      "$mainMod" = "SUPER";

      env = [
        "XCURSOR_SIZE,24"
        "ELECTRON_OZONE_PLATFORM_HINT,wayland"
        "SDL_VIDEODRIVER,wayland"
        "QT_QPA_PLATFORM,wayland"
        "QT_QPA_PLATFORMTHEME,qt5ct"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_STYLE_OVERRIDE,kvantum"
      ];

      windowrule = let
        float-left = "class:(io.github.Qalculate.qalculate-)((qt)|(gtk))$";
        float-right = "class:^(io\.missioncenter\.MissionCenter)|(nm-connection-editor)|(\.blueman-manager-wrapped)$";
      in [
        "float,${float-left}"
        "size 30% 80%,${float-left}"
        "move 5% 10%,${float-left}"
        # "workspace special,${float-left}"

        "float,class:^(Mullvad VPN)$"
        # "size 25% 80%,^(Mullvad VPN)$"
        "move 11.7% 23.7%,class:^(Mullvad VPN)$"

        "float,${float-right}"
        "size 60% 60%,${float-right}"
        "move 35% 20%,${float-right}"

        "float,${float-right}"
        "size 60% 60%,${float-right}"
        "move 35% 20%,${float-right}"

        "float,${float-right}"
        "size 60% 60%,${float-right}"
        "move 35% 20%,${float-right}"

        "float,title:^(Confirm to replace files)$"
        "float,title:^(File Operation Progress)$"

        "float,class:^(pavucontrol)$"
        "size 60% 80%,class:^(pavucontrol)$"
        "move 35% 10%,class:^(pavucontrol)$"

        "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
        "noanim,class:^(xwaylandvideobridge)$"
        "nofocus,class:^(xwaylandvideobridge)$"
        "noinitialfocus,class:^(xwaylandvideobridge)$"
      ];

      animations = {
        enabled = "yes";

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
          "specialWorkspace, 1, 3, default, slidefadevert 20%"
        ];
      };

      bind = let
        browser_f = "librewolf";
        browser_w = "chromium";
      in
        [
          # app launchers
          # "$mainMod, A, exec, arduino"
          # "$mainMod, B, exec, bitwarden"
          "$mainMod, D, exec, discord"
          "$mainMod, E, exec, thunar"
          "$mainMod, F, exec, ${browser_f}"
          "$mainMod SHIFT, F, exec, ${browser_f} --private-window"
          "$mainMod CTRL, F, exec, MOZ_ENABLE_WAYLAND=0 ${browser_f}"
          "$mainMod, G, exec, steam"
          "$mainMod, I, exec, gimp"
          "$mainMod, K, exec, kicad"
          "$mainMod, M, exec, prismlauncher"
          "$mainMod, N, exec, obsidian"
          "$mainMod, O, exec, obs"
          "$mainMod, Q, exec, toggle-calc"
          # hyprctl monitors | grep 'special workspace: -' && hyprctl dispatch togglespecialworkspace q || sh -c 'pgrep qalculate && hyprctl dispatch focuswindow qalculate || hyprctl dispatch exec \"[workspace special:q] qalculate-gtk\"'"
          "$mainMod SHIFT, Q, exec, qalculate-gtk"
          "SUPER, P, exec, sh -c \"if [ $(pidof waybar) ]; then pkill waybar; else waybar; fi\""
          "$mainMod, R, exec, wofi --show drun --allow-images --allow-markup"
          "$mainMod, S, exec, spotify"
          "$mainMod, T, exec, kitty"
          "$mainMod SHIFT, T, exec, alacritty"
          "$mainMod, V, exec, mullvad-vpn"
          "$mainMod, W, exec, ${browser_w}"
          "$mainMod SHIFT, W, exec, ${browser_w} --incognito"

          "CTRL ALT, DELETE, exec, missioncenter"
          "CTRL, ESCAPE, exec, missioncenter"

          "$mainMod, C, killactive, "
          "$mainMod SHIFT, X, exit, "
          "$mainMod SHIFT, S, exec, screenshot"
          ", Print, exec, screenshot"
          "$mainMod SHIFT, V, togglefloating"
          #bind = $mainMod, P, pseudo, # dwindle

          # Move focus with mainMod + arrow keys
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"

          # Scroll through existing workspaces with mainMod + scroll
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"

          # Fn keys
          ", XF86AudioMute, exec, volume mute" # F1
          ", XF86AudioLowerVolume, exec, volume down" # F2
          ", XF86AudioRaiseVolume, exec, volume up" # F3
          ", XF86MonBrightnessDown, exec, brightness down" # F4
          ", XF86MonBrightnessUp, exec, brightness up" # F5
          # ", XF86TouchpadToggle, exec, kitty" # F6
          # "SUPER, l, exec, kitty" # F9
          # ", XF86WebCam, exec, kitty" # F10
          ", XF86Launch1, exec, codium ~/Source/dotfiles" # F12
          "$mainMod, F12, exec, codium ~/Source/dotfiles" # F12
        ]
        ++ (builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "$mainMod, ${ws}, workspace, ${toString (x + 1)}"
              "$mainMod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10));

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      exec-once = with pkgs; [
        "waybar"
        "dunst"
        "hyprpaper"
        "fcitx5 -d"
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        "[workspace special:q silent] qalculate-gtk"
      ];

      decoration = {
        dim_special = 0;
        # shadow.enabled = "true";
        # shadow_range = 4;
        # shadow_render_power = 3;
        # "col.shadow" = "rgba(1a1a1aee)";
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
        # smart_split = "yes";
        # no_gaps_when_only = 1;
      };

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 1;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        resize_on_border = true;
        layout = "dwindle";
      };

      gestures = {
        workspace_swipe = "off";
      };

      input = {
        kb_layout = "pl";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";
        special_fallthrough = true;
        follow_mouse = 1;

        touchpad = {
          natural_scroll = "yes";
        };

        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
      };

      misc = {
        # disable_autoreload = "true";
        disable_hyprland_logo = "true";
        disable_splash_rendering = "true";
        enable_swallow = "true";
        swallow_regex = "^(kitty)|(Alacritty)$";
        swallow_exception_regex = "^(wev)$";
        # initial_workspace_tracking = 2;
      };

      source = "~/.config/hypr/extra.conf";
    };

    sourceFirst = false;

    xwayland.enable = true;
  };
}
