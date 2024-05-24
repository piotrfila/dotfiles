{ pkgs }:

pkgs.writeShellScriptBin "volume" ''
  # config
  steps=($(seq 0 5 150))

  # find current volume step
  current_volume=$(wpctl-current-sink get-volume)
  current_volume=''\${current_volume:8:1}''\${current_volume:10:2}
  current_step=$((''\${#steps[@]} - 1))
  for i in $(seq 0 $((''\${#steps[@]} - 2))); do
    thresh=($(((''\${steps[i]} + ''\${steps[i+1]}) / 2)))
    if [ $current_volume -le $thresh ]; then
      current_step=$i
      break
    fi
  done

  # increase or decrease brighness
  if [ $1 = "up" ] || [ $1 = "+" ]; then
    wpctl-current-sink set-mute 0
    if [ $current_step -lt $((''\${#steps[@]} - 1)) ]; then
      current_step=$(($current_step + 1))
      wpctl-current-sink set-volume ''\${steps[$current_step]}%
    fi
  elif [ $1 = "down" ] || [ $1 = "-" ]; then
    wpctl-current-sink set-mute 0
    if [ $current_step -gt 0 ]; then
      current_step=$(($current_step - 1))
      wpctl-current-sink set-volume ''\${steps[$current_step]}%
    fi
  # toggle mute
  elif [ $1 = "mute" ]; then
    wpctl-current-sink set-mute toggle
  fi

  muted=$(wpctl-current-sink is-muted)

  icon_dir="${pkgs.faba-icon-theme}/share/icons/Faba/symbolic/status"
  if [ "$muted" = "1" ]; then
    icon="$icon_dir/audio-volume-muted-symbolic.svg"
    bar="         "
  else
    if [ $current_step -ge 14 ]; then
      icon="$icon_dir/audio-volume-high-symbolic.svg"
    elif [ $current_step -ge 7 ]; then
      icon="$icon_dir/audio-volume-medium-symbolic.svg"
    else
      icon="$icon_dir/audio-volume-low-symbolic.svg"
    fi

    bar=""
    x=$current_step
    for i in $(seq 10); do
      if [ $x -ge 21 ]; then
        bar="$bar "
        x=$(($x - 1))
      elif [ $x -ge 2 ]; then
        bar="$bar "
        x=$(($x - 2))
      elif [ $x = 1 ]; then
        bar="$bar "
        x=0
      else
        bar="$bar "
      fi
    done
    bar="$bar "
  fi

  # bar="<span style=\"font-size: 16\">$bar</span>"

  # show notification
  ${pkgs.libnotify}/bin/notify-send -i "$icon" -t 2000 --replace-id=555 "$bar" ""
''