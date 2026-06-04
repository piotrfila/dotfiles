{
  osConfig,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./scripts/brightness.nix
    ./scripts/battery-charge-cap.nix
    ./scripts/volume.nix
    ./scripts/wpctl-current-sink.nix
  ];
  home.packages = with pkgs; [
    pavucontrol
    playerctl
    util-linux
    wl-clipboard
  ];
  programs.waybar = {
    enable = true;
    settings.mainBar = {
      layer = "top";
      position = "top";
      mod = "dock";
      exclusive = true;
      passthrough = false;
      gtk-layer-shell = true;
      height = 0;
      modules-left = [
        "clock#date"
        "hyprland/workspaces"
        "tray"
      ];
      modules-center = ["mpris"];
      modules-right =
        if osConfig.networking.hostName == "um425"
        then [
          "bluetooth"
          "network"
          "backlight"
          # "idle_inhibitor"
          "battery"
          "pulseaudio"
          "clock"
          "custom/power-btn"
        ]
        else [
          "network"
          "pulseaudio"
          "clock"
          "custom/power-btn"
        ];
      backlight = {
        device = "intel_backlight";
        format = "{icon}";
        format-icons = ["" "" "" "" "" "" "" "" "" "" "" "" "" "" ""];
        tooltip-format = "Jasność: {percent}%";
        on-click = "battery-charge-cap 60";
        on-click-middle = "battery-charge-cap 80";
        on-click-right = "battery-charge-cap 100";
        on-scroll-up = "brightness up";
        on-scroll-down = "brightness down";
      };
      battery = {
        format = "{icon} {capacity}%";
        format-charging = "󰂄 {capacity}%";
        format-icons = ["󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        format-plugged = "󰁹 {capacity}%";
        format-time = "{H}:{m}";
        interval = 60;
        # on-click = "battery-charge-cap 60";
        # on-click-middle = "battery-charge-cap 80";
        # on-click-right = "battery-charge-cap 100";
        on-scroll-up = "battery-charge-cap up";
        on-scroll-down = "battery-charge-cap down";
        states = {
          warning = 30;
          critical = 15;
        };
        tooltip-format-discharging = "Pozostało do wyczerpania: {time}";
        tooltip-format-discharging-warning = "Pozostało do wyczerpania: {time}\nNiski poziom baterii";
        tooltip-format-discharging-critical = "Pozostało do wyczerpania: {time}\nBardzo niski poziom baterii";
        tooltip-format-full = "Naładowano w pełni";
        tooltip-format-charging = "Pozostało do naładowania: {time}";
        tooltip-format-plugged = "Podłączony";
      };
      bluetooth = {
        format = " {status}";
        format-on = "󰂯";
        format-off = "󰂯";
        format-disabled = "󰂲";
        format-connected = " {device_alias}";
        format-connected-battery = " {device_alias} {device_battery_percentage}%";
        tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
        tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
        tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
        tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
        on-click = "rfkill unblock bluetooth";
        on-click-right = "rfkill block bluetooth";
        on-click-middle = "blueman-manager";
        format-icons = ["󰥇" "󰤾" "󰤿" "󰥀" "󰥁" "󰥂" "󰥃" "󰥄" "󰥅" "󰥆" "󰥈"];
      };
      clock = {
        format = " {:%R}";
        tooltip-format = "<tt><big>{:%d} {calendar}</big></tt>";
      };
      "clock#date" = {
        format = " {:L%A, %e %B}";
        tooltip-format = "<tt><big>{:%d} {calendar}</big></tt>";
      };
      "custom/power-btn" = {
        format = "";
        on-double-click = "poweroff";
        on-double-click-right = "reboot";
      };
      "hyprland/workspaces" = {
        show-special = true;
      };
      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = "";
          deactivated = "";
        };
        timeout = 30.5;
        tooltip-format-activated = "Tryb prezentacji aktywny";
        tooltip-format-deactivated = "Tryb prezentacji nieaktywny";
      };
      mpris = {
        dynamic-order = ["title" "artist"];
        format = "{player_icon}{dynamic}";
        max-length = 80;
        player-icons = {
          chromium = " ";
          default = "";
          firefox = "󰈹 ";
          spotify = " ";
          vlc = "󰕼 ";
        };
        status-icons = {
          paused = "⏸";
        };
      };
      network = {
        format = "{ifname}";
        format-disabled = "󰀝";
        format-disconnected = "󰌙";
        format-ethernet = "󰈀";
        format-linked = "󰈀"; # 󰌹 {ifname}";
        format-wifi = "{icon} {essid}";
        tooltip-format = "{ifname}";
        # tooltip-format-disconnected = "Brak dostępu do sieci {ifname}";
        tooltip-format-disabled = "Tryb samolotowy";
        # tooltip-format-ethernet = "Podłączono przez interfejs {ifname}";
        # tooltip-format-linked = "Podłączono przez interfejs {ifname}";
        tooltip-format-wifi = "{ifname}: {signalStrength}%";
        max-length = 20;
        on-click = "rfkill unblock wlan";
        on-click-right = "rfkill block wlan";
        format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
      };
      pulseaudio = {
        format = "{icon} {volume}%";
        tooltip = false;
        format-muted = " wył";
        on-click = "volume mute";
        on-click-right = "pavucontrol";
        on-scroll-up = "volume up";
        on-scroll-down = "volume down";
        scroll-step = 5;
        format-icons = {
          headphone = "";
          hands-free = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = ["" "" ""];
        };
      };
      tray = {
        icon-size = 16;
        spacing = 8;
      };
    };
    style = ./waybar-style.css;
  };
  wayland.windowManager.hyprland.settings = {
    exec-once = ["waybar"];
    windowrule = [
      {
        name = "pavucontrol";
        "match:class" = "^(pavucontrol)$";
        float = true;
        move = "(monitor_w*0.35) (monitor_h*0.10)";
        size = "(monitor_w*0.60) (monitor_h*0.80)";
      }
    ];
  };
}
