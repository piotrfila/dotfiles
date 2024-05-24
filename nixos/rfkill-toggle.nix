{pkgs}:
pkgs.writeShellScriptBin "rfkill-toggle" ''
  is_blocked=$(
    ${pkgs.util-linux}/bin/rfkill list $1 | \
    grep 'yes$' \
  )
  if [ "$is_blocked" = "" ] ; then
    ${pkgs.util-linux}/bin/rfkill block $1
  else
    ${pkgs.util-linux}/bin/rfkill unblock $1
  fi
''
