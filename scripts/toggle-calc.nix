{ pkgs }:

pkgs.writeShellScriptBin "toggle-calc" ''
  pidq=$(hyprctl clients -j | ${pkgs.jq}/bin/jq '[.[] | select(.workspace.name | contains("special:q")) | select(.class | contains("qalculate"))][0] | "\(.pid).\(.monitor)"')
  pidq=''${pidq//\"}
  echo $pidq
  # start qalculate if it is not running
  if [ $pidq == "null.null" ]; then
    hyprctl dispatch exec '[workspace special:q] qalculate-gtk'
    exit 0
  fi
  
  # pid of focused window
  pidf=$(hyprctl activewindow -j | ${pkgs.jq}/bin/jq '"\(.pid).\(.monitor)"')
  pidf=''${pidf//\"}
  pidf_saved="/tmp/pf-pidf"
  
  # check if special workspace is visible
  special=$(hyprctl monitors -j | ${pkgs.jq}/bin/jq '.[] | "w\(.specialWorkspace.name).\(.id)"')
  special=''${special//\"}
  
  for s in $special; do
    if [ ''${s%.*} == "wspecial:q" ]; then
      # hide if it was visible
      hyprctl dispatch togglespecialworkspace q
  
      # if focus was still on qalculate, restore old focus
      if [ $pidf == $pidq ]; then
        hyprctl dispatch focuswindow pid:$(cat $pidf_saved)
        exit 0
  
      # else if monitor was still the same, do nothing
      elif [ ''${pidf##*.} == ''${pidq##*.} ]; then
        exit 0
      fi
    fi
  done
  
  # otherwise switch focus to qalculate pid
  hyprctl dispatch focuswindow pid:''${pidq%.*}
  
  # save previous focus
  echo ''${pidf%.*} > $pidf_saved
''