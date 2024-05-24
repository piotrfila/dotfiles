{ pkgs }:

pkgs.writeShellScriptBin "wpctl-current-sink" ''
  current_sink=$(\
    ${pkgs.wireplumber}/bin/wpctl status | \
    grep "^ │  \*" | \
    head -n 1 \
  )
  
  if [ $1 = "is-muted" ]; then
    if [ "''\${current_sink/"MUTED]"//}" = "$current_sink" ]; then
      echo "0"
    else
      echo "1"
    fi
  else
    ${pkgs.wireplumber}/bin/wpctl $1 ''\${current_sink:8:2} $2
  fi
''