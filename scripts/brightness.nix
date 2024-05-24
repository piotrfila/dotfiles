{ pkgs }:

pkgs.writeShellScriptBin "brightness" ''
  # config
  backlight_dev="/sys/class/backlight/amdgpu_bl1"
  steps=(0 6 14 24 37 54 76 105 143 192 255)

  # find current brightness step
  current_brightness=$(<"$backlight_dev/brightness")
  current_step=$((''\${#steps[@]} - 1))
  for i in $(seq 0 $((''\${#steps[@]} - 2))); do
    thresh=($(((''\${steps[i]} + ''\${steps[i+1]}) / 2)))
    if [ $current_brightness -le $thresh ]; then
      current_step=$i
      break
    fi
  done

  echo $current_step

  # increase or decrease brighness
  if [ $1 = "up" ] || [ $1 = "+" ]; then
    if [ $current_step -lt $((''\${#steps[@]} - 1)) ]; then
      current_step=$(($current_step + 1))
      echo "''\${steps[$current_step]}" > $backlight_dev/brightness
    fi
  elif [ $1 = "down" ] || [ $1 = "-" ]; then
    if [ $current_step -gt 0 ]; then
      current_step=$(($current_step - 1))
      echo "''\${steps[$current_step]}" > $backlight_dev/brightness
    fi
  fi

  icon="${pkgs.faba-icon-theme}/share/icons/Faba/symbolic/status/display-brightness-symbolic.svg"

  bar=""
  x=$current_step
  for i in $(seq 10); do
    if [ $x -ge 1 ]; then
      bar="$bar "
      x=$(($x - 1))
    else
      bar="$bar "
    fi
  done
  bar="$bar "

  ${pkgs.libnotify}/bin/notify-send -i $icon -t 2000 --replace-id=556 "$bar" ""
''