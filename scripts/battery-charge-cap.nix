{pkgs, ...}: {
  home.packages = with pkgs; [
    libnotify
    (writeShellScriptBin "battery-charge-cap" ''
      save_file="$XDG_CONFIG_HOME/batt-cap"
      control_file="/sys/class/power_supply/BATT/charge_control_end_threshold"

      if [ $1 = "60" ]; then raw=60
      elif [ $1 = "80" ]; then raw=80
      elif [ $1 = "100" ]; then raw=100
      elif [ $1 = "up" ] || [ $1 = "+" ]; then
        raw=find
        offset="+ 20"
      elif [ $1 = "down" ] || [ $1 = "-" ]; then
        raw=find
        offset="- 20"
      fi

      if [ $raw = find ]; then
        current_value=$(<$control_file)
        current_value=$(($current_value $offset))

        if [ $current_value -lt 70 ]; then raw=60
        elif [ $current_value -lt 90 ]; then raw=80
        else raw=100; fi
      fi

      if [ $raw = 60 ]; then
        disp="60"
        icon=040
      elif [ $raw = 80 ]; then
        disp="80"
        icon=080
      elif [ $raw = 100 ]; then
        disp="100"
        icon=100
      fi

      echo $raw > $save_file
      echo $raw > $control_file

      icon="${faba-icon-theme}/share/icons/Faba/24x24/panel/gpm-battery-$icon-charging.svg"
      notify-send -i $icon -t 2000 --replace-id=557 "Ustawiono limit naładowania baterii na $disp%"
    '')
  ];
}
