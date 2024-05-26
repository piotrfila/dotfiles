{ pkgs, ... }: {
  home.packages = with pkgs; [
    wireplumber
    (writeShellScriptBin  "wpctl-current-sink" ''
    current_sink=$(\
      wpctl status | \
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
      wpctl $1 ''\${current_sink:8:2} $2
    fi
    '')
  ];
}